from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from config.routes import RoomsRoutes
from .models import Building, Equipment, Room

User = get_user_model()


# test the room and building api endpoints
class RoomAPITests(APITestCase):
    # create shared users, room data, and urls used by the test cases
    def setUp(self):
        self.buildings_url = reverse(RoomsRoutes.BUILDING_LIST_FULL_NAME)
        self.equipments_url = reverse(RoomsRoutes.EQUIPMENT_LIST_FULL_NAME)
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

    # public list endpoints should return the current room data
    def test_get_building_list_success(self):
        response = self.client.get(self.buildings_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["name"], "Library Building")

    def test_get_equipment_list_success(self):
        response = self.client.get(self.equipments_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 2)
        self.assertEqual(response.data[0]["name"], "Projector")

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

    # only admins can create new rooms
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

    def test_admin_update_room_success(self):
        update_url = reverse(RoomsRoutes.ADMIN_UPDATE_FULL_NAME, kwargs={"pk": self.room.id})

        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "name": "Room 101 Updated",
            "capacity": 8,
            "location": "Second Floor",
            "is_active": True,
            "building": self.building.id,
            "equipment": [self.equipment1.id],
        }

        response = self.client.put(update_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.room.refresh_from_db()
        self.assertEqual(self.room.name, "Room 101 Updated")
        self.assertEqual(self.room.capacity, 8)

    def test_admin_delete_room_success(self):
        delete_url = reverse(RoomsRoutes.ADMIN_DELETE_FULL_NAME, kwargs={"pk": self.room.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.assertEqual(Room.objects.count(), 0)

    # admins should be able to manage buildings and equipment records
    def test_admin_create_building_success(self):
        create_url = reverse(RoomsRoutes.ADMIN_BUILDING_CREATE_FULL_NAME)

        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "name": "Teaching Building",
            "campus_area": "West Campus",
            "opening_hours": "09:00-21:00",
        }

        response = self.client.post(create_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Building.objects.count(), 2)

    def test_admin_update_building_success(self):
        update_url = reverse(RoomsRoutes.ADMIN_BUILDING_UPDATE_FULL_NAME, kwargs={"pk": self.building.id})

        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "name": "Library Building Updated",
            "campus_area": "Main Campus",
            "opening_hours": "07:00-23:00",
        }

        response = self.client.put(update_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.building.refresh_from_db()
        self.assertEqual(self.building.name, "Library Building Updated")

    def test_admin_delete_building_fail_when_has_rooms(self):
        delete_url = reverse(RoomsRoutes.ADMIN_BUILDING_DELETE_FULL_NAME, kwargs={"pk": self.building.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data["detail"], "Cannot delete building with rooms.")

    def test_admin_delete_building_success(self):
        empty_building = Building.objects.create(
            name="Empty Building",
            campus_area="West Campus",
            opening_hours="09:00-21:00",
        )

        delete_url = reverse(RoomsRoutes.ADMIN_BUILDING_DELETE_FULL_NAME, kwargs={"pk": empty_building.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.assertFalse(Building.objects.filter(pk=empty_building.id).exists())

    def test_admin_create_equipment_success(self):
        create_url = reverse(RoomsRoutes.ADMIN_EQUIPMENT_CREATE_FULL_NAME)

        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "name": "Speaker",
            "status": "available",
        }

        response = self.client.post(create_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Equipment.objects.count(), 3)

    def test_admin_update_equipment_success(self):
        update_url = reverse(RoomsRoutes.ADMIN_EQUIPMENT_UPDATE_FULL_NAME, kwargs={"pk": self.equipment1.id})

        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "name": "Projector Updated",
            "status": "maintenance",
        }

        response = self.client.put(update_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.equipment1.refresh_from_db()
        self.assertEqual(self.equipment1.name, "Projector Updated")
        self.assertEqual(self.equipment1.status, "maintenance")

    def test_admin_delete_equipment_success(self):
        delete_url = reverse(RoomsRoutes.ADMIN_EQUIPMENT_DELETE_FULL_NAME, kwargs={"pk": self.equipment2.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.assertFalse(Equipment.objects.filter(pk=self.equipment2.id).exists())
