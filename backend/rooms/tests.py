from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from config.routes import RoomsRoutes
from .models import Building, Equipment, Room

User = get_user_model()


class RoomAPITests(APITestCase):
    def setUp(self):
        self.buildings_url = reverse(RoomsRoutes.BUILDING_LIST_FULL_NAME)
        self.rooms_url = reverse(RoomsRoutes.ROOM_LIST_FULL_NAME)
        self.room_create_url = reverse(RoomsRoutes.ADMIN_CREATE_FULL_NAME)

        self.admin_user = User.objects.create_user(
            username="admin1",
            email="admin@test.com",
            password="Test123456",
            role="admin",
        )

        self.student_user = User.objects.create_user(
            username="student1",
            email="student@test.com",
            password="Test123456",
            role="student",
        )

        self.building = Building.objects.create(
            name="Library Building",
            campus_area="Main Campus",
            opening_hours="08:00-22:00",
        )

        self.equipment1 = Equipment.objects.create(name="Projector", status="available")
        self.equipment2 = Equipment.objects.create(name="Whiteboard", status="available")

        self.room = Room.objects.create(
            name="Room 101",
            capacity=6,
            location="First Floor",
            is_active=True,
            building=self.building,
        )
        self.room.equipment.set([self.equipment1, self.equipment2])

    def test_get_building_list_success(self):
        response = self.client.get(self.buildings_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["name"], "Library Building")

    def test_get_room_list_success(self):
        response = self.client.get(self.rooms_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["name"], "Room 101")

    def test_get_room_detail_success(self):
        url = reverse(RoomsRoutes.ROOM_DETAIL_FULL_NAME, kwargs={"pk": self.room.id})
        response = self.client.get(url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["name"], "Room 101")
        self.assertEqual(response.data["capacity"], 6)

    def test_get_room_detail_not_found(self):
        url = reverse(RoomsRoutes.ROOM_DETAIL_FULL_NAME, kwargs={"pk": 9999})
        response = self.client.get(url)

        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

    def test_admin_create_room_success(self):
        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "name": "Room 202",
            "capacity": 10,
            "location": "Second Floor",
            "is_active": True,
            "building": self.building.id,
            "equipment": [self.equipment1.id],
        }

        response = self.client.post(self.room_create_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Room.objects.count(), 2)

    def test_create_room_fail_without_authentication(self):
        payload = {
            "name": "Room 202",
            "capacity": 10,
            "location": "Second Floor",
            "is_active": True,
            "building": self.building.id,
            "equipment": [self.equipment1.id],
        }

        response = self.client.post(self.room_create_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)