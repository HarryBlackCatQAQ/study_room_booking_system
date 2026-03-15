from rest_framework import serializers

from .models import SupportConversation, SupportMessage


# define a serializer for support messages
class SupportMessageSerializer(serializers.ModelSerializer):
    # expose sender information to the frontend message card
    sender_username = serializers.CharField(source='sender.username', read_only=True)
    sender_role = serializers.CharField(source='sender.role', read_only=True)

    class Meta:
        model = SupportMessage
        fields = [
            'id',
            'conversation',
            'sender',
            'sender_username',
            'sender_role',
            'content',
            'created_at',
            'is_read_by_student',
            'is_read_by_admin',
        ]
        read_only_fields = [
            'conversation',
            'sender',
            'sender_username',
            'sender_role',
            'created_at',
            'is_read_by_student',
            'is_read_by_admin',
        ]


# define a serializer for creating a new support message
class SupportMessageCreateSerializer(serializers.Serializer):
    content = serializers.CharField(max_length=1000)

    # keep message content clean before saving
    def validate_content(self, value):
        cleaned_value = value.strip()

        if not cleaned_value:
            raise serializers.ValidationError("Message content cannot be empty.")

        return cleaned_value


# define a serializer for support conversation list cards
class SupportConversationListSerializer(serializers.ModelSerializer):
    # expose user information for the admin queue
    student_username = serializers.CharField(source='student.username', read_only=True)
    student_email = serializers.CharField(source='student.email', read_only=True)
    assigned_admin_username = serializers.CharField(source='assigned_admin.username', read_only=True, allow_null=True)

    # unread counts are calculated from the related support messages
    unread_count_for_admin = serializers.SerializerMethodField()
    unread_count_for_student = serializers.SerializerMethodField()

    # show the latest message preview in the list
    latest_message_preview = serializers.SerializerMethodField()

    class Meta:
        model = SupportConversation
        fields = [
            'id',
            'student',
            'student_username',
            'student_email',
            'assigned_admin',
            'assigned_admin_username',
            'status',
            'created_at',
            'updated_at',
            'last_message_at',
            'unread_count_for_admin',
            'unread_count_for_student',
            'latest_message_preview',
        ]

    # get the unread message count for the admin side
    def get_unread_count_for_admin(self, obj):
        annotated_value = getattr(obj, 'unread_count_for_admin', None)

        if annotated_value is not None:
            return annotated_value

        return obj.messages.filter(sender__role='student', is_read_by_admin=False).count()

    # get the unread message count for the student side
    def get_unread_count_for_student(self, obj):
        annotated_value = getattr(obj, 'unread_count_for_student', None)

        if annotated_value is not None:
            return annotated_value

        return obj.messages.filter(sender__role='admin', is_read_by_student=False).count()

    # get the latest message preview for the list item
    def get_latest_message_preview(self, obj):
        latest_message = obj.messages.order_by('-created_at', '-id').first()

        if latest_message:
            return latest_message.content

        return 'No support messages yet.'


# define a serializer for support conversation detail
class SupportConversationDetailSerializer(SupportConversationListSerializer):
    messages = SupportMessageSerializer(many=True, read_only=True)

    class Meta(SupportConversationListSerializer.Meta):
        fields = SupportConversationListSerializer.Meta.fields + ['messages']
