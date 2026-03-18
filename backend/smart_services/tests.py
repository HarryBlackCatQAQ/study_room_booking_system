from datetime import time, timedelta
from unittest.mock import MagicMock, patch

import grpc
import study_room_services_pb2 as pb
from django.contrib.auth import get_user_model
from django.utils import timezone
from rest_framework import status
from rest_framework.test import APITestCase

from bookings.models import Booking
from rooms.models import Building, Equipment, Room

User = get_user_model()


class FakeRpcError(grpc.RpcError):
    # keep a small grpc error helper so the api error path can be tested directly
    def __init__(self, status_code, details):
        self._status_code = status_code
        self._details = details

    def code(self):
        return self._status_code

    def details(self):
        return self._details


# test the smart service api endpoints for recommendation and availability
class SmartServiceAPITests(APITestCase):
    # create shared users, room data, and urls used by the test cases
    def setUp(self):
        self.recommendations_url = "/api/smart/recommendations/"
        self.available_slots_url = "/api/smart/available-slots/"
        self.search_date = timezone.localdate() + timedelta(days=2)

        self.student_user = User.objects.create_user(
            username="student1",
            email="student1@test.com",
            password="Test123456",
            role="student",
        )

        self.building = Building.objects.create(
            name="Library Building",
            campus_area="Main Campus",
            opening_hours="08:00-22:00",
        )

        self.equipment = Equipment.objects.create(
            name="Projector",
            status="available",
        )

        self.room = Room.objects.create(
            name="Room 101",
            capacity=6,
            location="First Floor",
            is_active=True,
            building=self.building,
        )
        self.room.equipment.set([self.equipment])

        self.booking = Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=self.search_date,
            start_time=time(10, 0),
            end_time=time(11, 0),
            status="approved",
        )

    # recommendation should return the grpc result as a normal api response
    @patch("smart_services.views.pb_grpc.RoomRecommendationServiceStub")
    @patch("smart_services.views.grpc.insecure_channel")
    def test_recommend_rooms_success(self, mock_channel_factory, mock_stub_class):
        self.client.force_authenticate(user=self.student_user)

        channel = MagicMock()
        channel.__enter__.return_value = channel
        mock_channel_factory.return_value = channel

        grpc_response = pb.RecommendationResponse(
            rooms=[
                pb.RecommendedRoom(
                    room_id=self.room.id,
                    room_name=self.room.name,
                    building_name=self.building.name,
                    score=0.95,
                    reason="Best room match",
                )
            ]
        )

        mock_stub = MagicMock()
        mock_stub.RecommendRooms.return_value = grpc_response
        mock_stub_class.return_value = mock_stub

        payload = {
            "min_capacity": 4,
            "preferred_building_id": self.building.id,
        }

        response = self.client.post(self.recommendations_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["room_name"], self.room.name)
        self.assertEqual(response.data[0]["building_name"], self.building.name)

        grpc_request = mock_stub.RecommendRooms.call_args.args[0]
        self.assertEqual(grpc_request.min_capacity, 4)
        self.assertEqual(grpc_request.preferred_building_id, self.building.id)
        self.assertEqual(len(grpc_request.rooms), 1)

    def test_recommend_rooms_fail_without_authentication(self):
        payload = {
            "min_capacity": 4,
        }

        response = self.client.post(self.recommendations_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_recommend_rooms_fail_when_min_capacity_invalid(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "min_capacity": 0,
        }

        response = self.client.post(self.recommendations_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    # grpc failures should become a clear api 503 response
    @patch("smart_services.views.pb_grpc.RoomRecommendationServiceStub")
    @patch("smart_services.views.grpc.insecure_channel")
    def test_recommend_rooms_fail_when_grpc_unavailable(self, mock_channel_factory, mock_stub_class):
        self.client.force_authenticate(user=self.student_user)

        channel = MagicMock()
        channel.__enter__.return_value = channel
        mock_channel_factory.return_value = channel

        mock_stub = MagicMock()
        mock_stub.RecommendRooms.side_effect = FakeRpcError(
            grpc.StatusCode.UNAVAILABLE,
            "java service is down",
        )
        mock_stub_class.return_value = mock_stub

        payload = {
            "min_capacity": 4,
        }

        response = self.client.post(self.recommendations_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_503_SERVICE_UNAVAILABLE)
        self.assertEqual(response.data["error_code"], grpc.StatusCode.UNAVAILABLE.name)

    # availability should return the grpc result as a normal api response
    @patch("smart_services.views.pb_grpc.AvailabilityServiceStub")
    @patch("smart_services.views.grpc.insecure_channel")
    def test_availability_search_success(self, mock_channel_factory, mock_stub_class):
        self.client.force_authenticate(user=self.student_user)

        channel = MagicMock()
        channel.__enter__.return_value = channel
        mock_channel_factory.return_value = channel

        grpc_response = pb.AvailabilityResponse(
            slots=[
                pb.AvailableSlot(
                    room_id=self.room.id,
                    room_name=self.room.name,
                    building_name=self.building.name,
                    start_time="11:00",
                    end_time="12:00",
                )
            ]
        )

        mock_stub = MagicMock()
        mock_stub.FindAvailableSlots.return_value = grpc_response
        mock_stub_class.return_value = mock_stub

        payload = {
            "booking_date": self.search_date.isoformat(),
            "search_start_time": "11:00:00",
            "search_end_time": "12:00:00",
            "building_id": self.building.id,
        }

        response = self.client.post(self.available_slots_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["room_name"], self.room.name)
        self.assertEqual(response.data[0]["start_time"], "11:00")

        grpc_request = mock_stub.FindAvailableSlots.call_args.args[0]
        self.assertEqual(grpc_request.building_id, self.building.id)
        self.assertEqual(len(grpc_request.rooms), 1)
        self.assertEqual(len(grpc_request.bookings), 1)

    def test_availability_search_fail_without_authentication(self):
        payload = {
            "booking_date": self.search_date.isoformat(),
            "search_start_time": "11:00:00",
            "search_end_time": "12:00:00",
        }

        response = self.client.post(self.available_slots_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_availability_search_fail_when_end_time_not_later(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "booking_date": self.search_date.isoformat(),
            "search_start_time": "12:00:00",
            "search_end_time": "11:00:00",
        }

        response = self.client.post(self.available_slots_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    # grpc failures should become a clear api 503 response
    @patch("smart_services.views.pb_grpc.AvailabilityServiceStub")
    @patch("smart_services.views.grpc.insecure_channel")
    def test_availability_search_fail_when_grpc_unavailable(self, mock_channel_factory, mock_stub_class):
        self.client.force_authenticate(user=self.student_user)

        channel = MagicMock()
        channel.__enter__.return_value = channel
        mock_channel_factory.return_value = channel

        mock_stub = MagicMock()
        mock_stub.FindAvailableSlots.side_effect = FakeRpcError(
            grpc.StatusCode.UNAVAILABLE,
            "go service is down",
        )
        mock_stub_class.return_value = mock_stub

        payload = {
            "booking_date": self.search_date.isoformat(),
            "search_start_time": "11:00:00",
            "search_end_time": "12:00:00",
        }

        response = self.client.post(self.available_slots_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_503_SERVICE_UNAVAILABLE)
        self.assertEqual(response.data["error_code"], grpc.StatusCode.UNAVAILABLE.name)
