import grpc
import study_room_services_pb2 as pb
import study_room_services_pb2_grpc as pb_grpc

from django.conf import settings
from rest_framework import permissions, serializers, status
from rest_framework.response import Response
from rest_framework.views import APIView

from bookings.models import Booking
from rooms.models import Room


# validate the demo room match request body
class RecommendationInputSerializer(serializers.Serializer):
    min_capacity = serializers.IntegerField(min_value=1, default=1)
    preferred_building_id = serializers.IntegerField(required=False, allow_null=True)


# validate the demo availability request body
class AvailabilityInputSerializer(serializers.Serializer):
    booking_date = serializers.DateField()
    search_start_time = serializers.TimeField()
    search_end_time = serializers.TimeField()
    building_id = serializers.IntegerField(required=False, allow_null=True)

    def validate(self, attrs):
        if attrs["search_start_time"] >= attrs["search_end_time"]:
            raise serializers.ValidationError(
                "search_end_time must be later than search_start_time."
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


# api view for asking the java service to return demo room matches
class RoomRecommendationView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        # validate the input first so grpc receives clean data
        serializer = RecommendationInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = serializer.validated_data

        # collect the current room data from django for the demo room match
        rooms = (
            Room.objects.all()
            .select_related("building")
            .prefetch_related("equipment")
        )

        # build the grpc request message using only the demo-friendly fields
        grpc_request = pb.RecommendationRequest(
            booking_date="",
            start_time="",
            end_time="",
            min_capacity=data["min_capacity"],
            required_equipment=[],
            preferred_building_id=data.get("preferred_building_id") or 0,
            rooms=[room_to_proto(room) for room in rooms],
            bookings=[],
            review_stats=[],
        )

        try:
            # call the java grpc demo room match service
            with grpc.insecure_channel(settings.JAVA_RECOMMENDATION_GRPC_TARGET) as channel:
                stub = pb_grpc.RoomRecommendationServiceStub(channel)
                grpc_response = stub.RecommendRooms(grpc_request, timeout=5)
        except grpc.RpcError as exc:
            # return a clear api error if the grpc service is unavailable
            return Response(
                {
                    "detail": "Demo room match is temporarily unavailable.",
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


# api view for asking the go service to check one exact time range
class AvailabilitySearchView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        # validate the input first so grpc receives clean data
        serializer = AvailabilityInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = serializer.validated_data

        # collect the current room and booking data from django
        rooms = (
            Room.objects.all()
            .select_related("building")
            .prefetch_related("equipment")
        )
        bookings = Booking.objects.filter(
            booking_date=data["booking_date"],
            status__in=["pending", "approved"],
        )

        # build the grpc request message for the demo availability check
        grpc_request = pb.AvailabilityRequest(
            booking_date=data["booking_date"].isoformat(),
            search_start_time=data["search_start_time"].strftime("%H:%M"),
            search_end_time=data["search_end_time"].strftime("%H:%M"),
            duration_minutes=0,
            min_capacity=0,
            building_id=data.get("building_id") or 0,
            required_equipment=[],
            rooms=[room_to_proto(room) for room in rooms],
            bookings=[booking_to_proto(booking) for booking in bookings],
        )

        try:
            # call the go grpc demo availability service
            with grpc.insecure_channel(settings.GO_AVAILABILITY_GRPC_TARGET) as channel:
                stub = pb_grpc.AvailabilityServiceStub(channel)
                grpc_response = stub.FindAvailableSlots(grpc_request, timeout=5)
        except grpc.RpcError as exc:
            # return a clear api error if the grpc service is unavailable
            return Response(
                {
                    "detail": "Demo availability check is temporarily unavailable.",
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
