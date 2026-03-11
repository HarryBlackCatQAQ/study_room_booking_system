from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from config.routes import ReviewsRoutes
from rooms.models import Building, Room
from .models import Review

User = get_user_model()


class ReviewAPITests(APITestCase):
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

        self.review = Review.objects.create(
            student=self.student_user,
            room=self.room,
            rating=5,
            comment="Very quiet and good for study.",
        )

    def test_get_all_reviews_success(self):
        response = self.client.get(self.reviews_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_get_reviews_by_room_success(self):
        response = self.client.get(f"{self.reviews_url}?room={self.room.id}")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]["room"], self.room.id)

    def test_create_review_success_with_authentication(self):
        self.client.force_authenticate(user=self.student_user)

        payload = {
            "room": self.room.id,
            "rating": 4,
            "comment": "Projector works well.",
        }

        response = self.client.post(self.reviews_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Review.objects.count(), 2)
        review = Review.objects.order_by("-id").first()
        self.assertEqual(review.student, self.student_user)

    def test_create_review_fail_without_authentication(self):
        payload = {
            "room": self.room.id,
            "rating": 4,
            "comment": "Projector works well.",
        }

        response = self.client.post(self.reviews_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)