from datetime import datetime
from django.utils import timezone
from rest_framework import serializers
from bookings.models import Booking
from .models import Review


class ReviewSerializer(serializers.ModelSerializer):
    student_username = serializers.CharField(source='student.username', read_only=True)

    booking = serializers.PrimaryKeyRelatedField(queryset=Booking.objects.all())

    rating = serializers.IntegerField(min_value=1, max_value=5)

    class Meta:
        model = Review
        fields = ['id', 'student', 'student_username', 'room', 'booking', 'rating', 'comment', 'created_at']
        read_only_fields = ['student', 'room', 'created_at']
    
    def validate(self, attrs):
        request = self.context['request']
        booking = attrs.get('booking')

        if not booking:
            raise serializers.ValidationError({'booking': 'This field is required.'})

        booking_end = timezone.make_aware(datetime.combine(booking.booking_date, booking.end_time))

        if booking.student_id != request.user.id:
            raise serializers.ValidationError('You can only review your own booking.')

        if booking.status != 'approved':
            raise serializers.ValidationError('Only approved bookings can be reviewed.')

        if timezone.now() < booking_end:
            raise serializers.ValidationError('You can only review a booking after it has ended.')

        if hasattr(booking, 'review'):
            raise serializers.ValidationError('This booking has already been reviewed.')

        return attrs