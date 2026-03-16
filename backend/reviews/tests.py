from datetime import time, timedelta

from django.contrib.auth import get_user_model
from django.urls import reverse
from django.utils import timezone
from rest_framework import status
from rest_framework.test import APITestCase

from bookings.models import Booking
from config.routes import ReviewsRoutes
from rooms.models import Building, Room
from .models import Review

User = get_user_model()


# test the review api for list and create behavior
class ReviewAPITests(APITestCase):
    # create shared users, room data, and bookings used by the test cases
    def setUp(self):
        self.reviews_url = reverse(ReviewsRoutes.LIST_CREATE_FULL_NAME)

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

        self.room = Room.objects.create(
            name="Room 101",
            capacity=6,
            location="First Floor",
            is_active=True,
            building=self.building,
        )

        today = timezone.now().date()

        self.ended_booking = Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=today - timedelta(days=1),
            start_time=time(9, 0),
            end_time=time(10, 0),
            status='approved',
        )

        self.future_booking = Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=today + timedelta(days=1),
            start_time=time(9, 0),
            end_time=time(10, 0),
            status='approved',
        )

        self.reviewed_booking = Booking.objects.create(
            student=self.student_user,
            room=self.room,
            booking_date=today - timedelta(days=2),
            start_time=time(14, 0),
            end_time=time(15, 0),
            status='approved',
        )

        self.review = Review.objects.create(
            student=self.student_user,
            room=self.room,
            booking=self.reviewed_booking,
            rating=5,
            comment="Very quiet and good for study.",
        )

    # listing reviews should work without login
    def test_get_all_reviews_success(self):
        response = self.client.get(self.reviews_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_get_reviews_by_room_success(self):
        response = self.client.get(f"{self.reviews_url}?room={self.room.id}")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["room"], self.room.id)

    # only finished approved bookings can be reviewed
    def test_create_review_success_for_ended_booking(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "booking": self.ended_booking.id,
            "rating": 4,
            "comment": "Projector works well.",
        }

        response = self.client.post(self.reviews_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Review.objects.count(), 2)

        review = Review.objects.get(booking=self.ended_booking)
        self.assertEqual(review.student, self.student_user)
        self.assertEqual(review.room, self.room)

    def test_create_review_fail_for_booking_not_ended(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "booking": self.future_booking.id,
            "rating": 4,
            "comment": "Too early to review.",
        }

        response = self.client.post(self.reviews_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(Review.objects.count(), 1)

    def test_create_review_fail_when_booking_already_reviewed(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "booking": self.reviewed_booking.id,
            "rating": 3,
            "comment": "Trying to submit again.",
        }

        response = self.client.post(self.reviews_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(Review.objects.count(), 1)

    # creating a review should require login
    def test_create_review_fail_without_authentication(self):
        payload = {
            "booking": self.ended_booking.id,
            "rating": 4,
            "comment": "Projector works well.",
        }

        response = self.client.post(self.reviews_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
