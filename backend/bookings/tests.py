from datetime import date, time

from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from config.routes import BookingsRoutes
from rooms.models import Building, Room
from .models import Booking

User = get_user_model()


class BookingAPITests(APITestCase):
    def setUp(self):
        self.bookings_url = reverse(BookingsRoutes.CREATE_FULL_NAME)
        self.my_bookings_url = reverse(BookingsRoutes.MY_LIST_FULL_NAME)
        self.admin_all_url = reverse(BookingsRoutes.ADMIN_LIST_FULL_NAME)

        self.student_user = User.objects.create_user(
            username="student1",
            email="student1@test.com",
            password="Test123456",
            role="student",
        )

        self.admin_user = User.objects.create_user(
            username="admin1",
            email="admin1@test.com",
            password="Test123456",
            role="admin",
        )

        self.building = Building.objects.create(
            name="Library Building",
            campus_area="Main Campus",
            opening_hours="08:00-22:00",
        )

        self.room = Room.objects.create(
            name="Room 101",
            capacity=6,
            location="First Floor",
            is_active=True,
            building=self.building,
        )

    def test_create_booking_success(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "room": self.room.id,
            "booking_date": "2026-03-10",
            "start_time": "10:00:00",
            "end_time": "12:00:00",
        }

        response = self.client.post(self.bookings_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Booking.objects.count(), 1)
        booking = Booking.objects.first()
        self.assertEqual(booking.student, self.student_user)
        self.assertEqual(booking.status, "pending")

    def test_create_booking_fail_without_authentication(self):
        payload = {
            "room": self.room.id,
            "booking_date": "2026-03-10",
            "start_time": "10:00:00",
            "end_time": "12:00:00",
        }

        response = self.client.post(self.bookings_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_create_booking_fail_when_end_time_not_later(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "room": self.room.id,
            "booking_date": "2026-03-10",
            "start_time": "14:00:00",
            "end_time": "12:00:00",
        }

        response = self.client.post(self.bookings_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_create_booking_fail_when_time_conflicts(self):
        Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="approved",
        )

        self.client.force_authenticate(user=self.student_user)

        payload = {
            "room": self.room.id,
            "booking_date": "2026-03-10",
            "start_time": "11:00:00",
            "end_time": "13:00:00",
        }

        response = self.client.post(self.bookings_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_get_my_bookings_only_current_user(self):
        other_user = User.objects.create_user(
            username="student2",
            email="student2@test.com",
            password="Test123456",
            role="student",
        )

        Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )

        Booking.objects.create(
            student=other_user,
            room=self.room,
            booking_date=date(2026, 3, 11),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )

        self.client.force_authenticate(user=self.student_user)
        response = self.client.get(self.my_bookings_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_cancel_own_booking_success(self):
        booking = Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )

        cancel_url = reverse(BookingsRoutes.CANCEL_FULL_NAME, kwargs={"pk": booking.id})

        self.client.force_authenticate(user=self.student_user)
        response = self.client.patch(cancel_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        booking.refresh_from_db()
        self.assertEqual(booking.status, "cancelled")

    def test_cancel_other_users_booking_fail(self):
        other_user = User.objects.create_user(
            username="student2",
            email="student2@test.com",
            password="Test123456",
            role="student",
        )

        booking = Booking.objects.create(
            student=other_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )

        cancel_url = reverse(BookingsRoutes.CANCEL_FULL_NAME, kwargs={"pk": booking.id})

        self.client.force_authenticate(user=self.student_user)
        response = self.client.patch(cancel_url)

        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

    def test_admin_get_all_bookings_success(self):
        Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.get(self.admin_all_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_admin_approve_booking_success(self):
        booking = Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )

        approve_url = reverse(BookingsRoutes.APPROVE_FULL_NAME, kwargs={"pk": booking.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.patch(approve_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        booking.refresh_from_db()
        self.assertEqual(booking.status, "approved")
        self.assertEqual(booking.processed_by, self.admin_user)

    def test_admin_reject_booking_success(self):
        booking = Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )

        reject_url = reverse(BookingsRoutes.REJECT_FULL_NAME, kwargs={"pk": booking.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.patch(reject_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        booking.refresh_from_db()
        self.assertEqual(booking.status, "rejected")
        self.assertEqual(booking.processed_by, self.admin_user)