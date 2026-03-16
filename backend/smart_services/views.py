import grpc
import study_room_services_pb2 as pb
import study_room_services_pb2_grpc as pb_grpc

from django.conf import settings
from django.db.models import Avg, Count
from rest_framework import permissions, serializers, status
from rest_framework.response import Response
from rest_framework.views import APIView

from bookings.models import Booking
from reviews.models import Review
from rooms.models import Room


# validate the room recommendation request body
class RecommendationInputSerializer(serializers.Serializer):
    booking_date = serializers.DateField()
    start_time = serializers.TimeField()
    end_time = serializers.TimeField()
    min_capacity = serializers.IntegerField(min_value=1, default=1)
    required_equipment = serializers.ListField(
        child=serializers.CharField(),
        required=False,
        default=list,
    )
    preferred_building_id = serializers.IntegerField(required=False, allow_null=True)

    def validate(self, attrs):
        if attrs["start_time"] >= attrs["end_time"]:
            raise serializers.ValidationError("end_time must be later than start_time.")
        return attrs


# validate the room availability search request body
class AvailabilityInputSerializer(serializers.Serializer):
    booking_date = serializers.DateField()
    search_start_time = serializers.TimeField()
    search_end_time = serializers.TimeField()
    duration_minutes = serializers.IntegerField(min_value=30)
    min_capacity = serializers.IntegerField(min_value=1, default=1)
    building_id = serializers.IntegerField(required=False, allow_null=True)
    required_equipment = serializers.ListField(
        child=serializers.CharField(),
        required=False,
        default=list,
    )

    def validate(self, attrs):
        if attrs["search_start_time"] >= attrs["search_end_time"]:
            raise serializers.ValidationError(
                "search_end_time must be later than search_start_time."
            )

        start_minutes = (
            attrs["search_start_time"].hour * 60 + attrs["search_start_time"].minute
        )
        end_minutes = (
            attrs["search_end_time"].hour * 60 + attrs["search_end_time"].minute
        )

        if attrs["duration_minutes"] > end_minutes - start_minutes:
            raise serializers.ValidationError(
                "duration_minutes cannot be greater than the search window."
            )

        return attrs


# convert one django room object into the proto message expected by grpc
def room_to_proto(room):
    return pb.RoomSnapshot(
        room_id=room.id,
        room_name=room.name,
        capacity=room.capacity,
        building_id=room.building_id,
        building_name=room.building.name,
        equipment_names=[item.name for item in room.equipment.all()],
        is_active=room.is_active,
    )


# convert one django booking object into the proto message expected by grpc
def booking_to_proto(booking):
    return pb.BookingSnapshot(
        room_id=booking.room_id,
        booking_date=booking.booking_date.isoformat(),
        start_time=booking.start_time.strftime("%H:%M"),
        end_time=booking.end_time.strftime("%H:%M"),
        status=booking.status,
    )


# api view for asking the java service to rank recommended rooms
class RoomRecommendationView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        # validate the input first so grpc receives clean data
        serializer = RecommendationInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = serializer.validated_data

        # collect the current room, booking, and review data from django
        rooms = (
            Room.objects.filter(is_active=True)
            .select_related("building")
            .prefetch_related("equipment")
        )
        bookings = Booking.objects.filter(
            booking_date=data["booking_date"],
            status__in=["pending", "approved"],
        )
        review_stats = Review.objects.values("room_id").annotate(
            average_rating=Avg("rating"),
            review_count=Count("id"),
        )

        # build the grpc request message from the django query results
        grpc_request = pb.RecommendationRequest(
            booking_date=data["booking_date"].isoformat(),
            start_time=data["start_time"].strftime("%H:%M"),
            end_time=data["end_time"].strftime("%H:%M"),
            min_capacity=data["min_capacity"],
            required_equipment=data.get("required_equipment", []),
            preferred_building_id=data.get("preferred_building_id") or 0,
            rooms=[room_to_proto(room) for room in rooms],
            bookings=[booking_to_proto(booking) for booking in bookings],
            review_stats=[
                pb.ReviewStat(
                    room_id=item["room_id"],
                    average_rating=float(item["average_rating"] or 0),
                    review_count=item["review_count"],
                )
                for item in review_stats
            ],
        )

        try:
            # call the java grpc recommendation service
            with grpc.insecure_channel(settings.JAVA_RECOMMENDATION_GRPC_TARGET) as channel:
                stub = pb_grpc.RoomRecommendationServiceStub(channel)
                grpc_response = stub.RecommendRooms(grpc_request, timeout=5)
        except grpc.RpcError as exc:
            # return a clear api error if the grpc service is unavailable
            return Response(
                {
                    "detail": "Room recommendation is temporarily unavailable.",
                    "error_code": exc.code().name,
                    "details": exc.details(),
                },
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )

        # convert the grpc response into a normal json response
        return Response(
            [
                {
                    "room_id": item.room_id,
                    "room_name": item.room_name,
                    "building_name": item.building_name,
                    "score": item.score,
                    "reason": item.reason,
                }
                for item in grpc_response.rooms
            ]
        )


# api view for asking the go service to find available room slots
class AvailabilitySearchView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        # validate the input first so grpc receives clean data
        serializer = AvailabilityInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = serializer.validated_data

        # collect the current room and booking data from django
        rooms = (
            Room.objects.filter(is_active=True)
            .select_related("building")
            .prefetch_related("equipment")
        )
        bookings = Booking.objects.filter(
            booking_date=data["booking_date"],
            status__in=["pending", "approved"],
        )

        # build the grpc request message from the django query results
        grpc_request = pb.AvailabilityRequest(
            booking_date=data["booking_date"].isoformat(),
            search_start_time=data["search_start_time"].strftime("%H:%M"),
            search_end_time=data["search_end_time"].strftime("%H:%M"),
            duration_minutes=data["duration_minutes"],
            min_capacity=data["min_capacity"],
            building_id=data.get("building_id") or 0,
            required_equipment=data.get("required_equipment", []),
            rooms=[room_to_proto(room) for room in rooms],
            bookings=[booking_to_proto(booking) for booking in bookings],
        )

        try:
            # call the go grpc availability service
            with grpc.insecure_channel(settings.GO_AVAILABILITY_GRPC_TARGET) as channel:
                stub = pb_grpc.AvailabilityServiceStub(channel)
                grpc_response = stub.FindAvailableSlots(grpc_request, timeout=5)
        except grpc.RpcError as exc:
            # return a clear api error if the grpc service is unavailable
            return Response(
                {
                    "detail": "Availability search is temporarily unavailable.",
                    "error_code": exc.code().name,
                    "details": exc.details(),
                },
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )

        # convert the grpc response into a normal json response
        return Response(
            [
                {
                    "room_id": item.room_id,
                    "room_name": item.room_name,
                    "building_name": item.building_name,
                    "start_time": item.start_time,
                    "end_time": item.end_time,
                }
                for item in grpc_response.slots
            ]
        )
