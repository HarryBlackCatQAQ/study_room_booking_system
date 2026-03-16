from datetime import date, time

from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from config.routes import UsersRoutes
from bookings.models import Booking
from reviews.models import Review
from rooms.models import Building, Room

User = get_user_model()


# test auth, profile, password, and admin user management endpoints
class UserAPITests(APITestCase):
    # create shared users, room data, and urls used by the test cases
    def setUp(self):
        self.register_url = reverse(UsersRoutes.REGISTER_FULL_NAME)
        self.login_url = reverse(UsersRoutes.LOGIN_FULL_NAME)
        self.me_url = reverse(UsersRoutes.ME_FULL_NAME)
        self.change_password_url = reverse(UsersRoutes.CHANGE_PASSWORD_FULL_NAME)
        self.admin_user_list_url = reverse(UsersRoutes.ADMIN_LIST_FULL_NAME)
        self.admin_user_create_url = reverse(UsersRoutes.ADMIN_CREATE_FULL_NAME)

        self.user = User.objects.create_user(
            username="existing_user",
            email="existing@test.com",
            password="Test123456",
            role="student",
        )

        self.admin_user = User.objects.create_user(
            username="admin_user",
            email="admin@test.com",
            password="Admin123456",
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

    # register and login endpoints should work for valid credentials
    def test_register_success(self):
        payload = {
            "username": "student1",
            "email": "student1@test.com",
            "password": "Test123456",
            "role": "student",
        }

        response = self.client.post(self.register_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(User.objects.count(), 3)
        self.assertEqual(response.data["username"], "student1")
        self.assertEqual(response.data["role"], "student")
        self.assertNotIn("password", response.data)

    def test_register_duplicate_username_fail(self):
        payload = {
            "username": "existing_user",
            "email": "another@test.com",
            "password": "Test123456",
            "role": "student",
        }

        response = self.client.post(self.register_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_login_success(self):
        payload = {
            "username": "existing_user",
            "password": "Test123456",
        }

        response = self.client.post(self.login_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn("access", response.data)
        self.assertIn("refresh", response.data)

    def test_login_fail_wrong_password(self):
        payload = {
            "username": "existing_user",
            "password": "WrongPassword123",
        }

        response = self.client.post(self.login_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    # the profile endpoint should return the current authenticated user
    def test_me_success_with_authentication(self):
        self.client.force_authenticate(user=self.user)

        response = self.client.get(self.me_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["username"], self.user.username)
        self.assertEqual(response.data["role"], self.user.role)

    def test_me_fail_without_authentication(self):
        response = self.client.get(self.me_url)

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    # changing the password should validate the current and new values
    def test_change_password_success(self):
        self.client.force_authenticate(user=self.user)

        payload = {
            "current_password": "Test123456",
            "new_password": "NewPass123",
            "confirm_password": "NewPass123",
        }

        response = self.client.post(self.change_password_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], "Password changed successfully. Please log in again.")

        self.user.refresh_from_db()
        self.assertTrue(self.user.check_password("NewPass123"))

    def test_change_password_fail_wrong_current_password(self):
        self.client.force_authenticate(user=self.user)

        payload = {
            "current_password": "WrongPassword123",
            "new_password": "NewPass123",
            "confirm_password": "NewPass123",
        }

        response = self.client.post(self.change_password_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data["detail"], "Current password is incorrect.")

    def test_change_password_fail_mismatch_confirm_password(self):
        self.client.force_authenticate(user=self.user)

        payload = {
            "current_password": "Test123456",
            "new_password": "NewPass123",
            "confirm_password": "AnotherPass123",
        }

        response = self.client.post(self.change_password_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data["detail"], "New password and confirm password do not match.")

    def test_change_password_fail_without_authentication(self):
        payload = {
            "current_password": "Test123456",
            "new_password": "NewPass123",
            "confirm_password": "NewPass123",
        }

        response = self.client.post(self.change_password_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    # admin endpoints should expose user statistics and management actions
    def test_admin_get_user_list_success(self):
        self.client.force_authenticate(user=self.admin_user)

        response = self.client.get(self.admin_user_list_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 2)
        self.assertIn("booking_count", response.data[0])
        self.assertIn("review_count", response.data[0])
        self.assertIn("processed_booking_count", response.data[0])

    def test_admin_create_user_success(self):
        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "username": "student2",
            "email": "student2@test.com",
            "password": "Student123456",
            "role": "student",
            "is_active": True,
        }

        response = self.client.post(self.admin_user_create_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(User.objects.count(), 3)
        created_user = User.objects.get(username="student2")
        self.assertTrue(created_user.check_password("Student123456"))

    def test_admin_update_user_success(self):
        update_url = reverse(UsersRoutes.ADMIN_UPDATE_FULL_NAME, kwargs={"pk": self.user.id})

        self.client.force_authenticate(user=self.admin_user)

        payload = {
            "username": "updated_user",
            "email": "updated@test.com",
            "role": "admin",
            "is_active": True,
        }

        response = self.client.put(update_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.user.refresh_from_db()
        self.assertEqual(self.user.username, "updated_user")
        self.assertEqual(self.user.email, "updated@test.com")
        self.assertEqual(self.user.role, "admin")

    def test_admin_delete_user_success(self):
        removable_user = User.objects.create_user(
            username="removable_user",
            email="removable@test.com",
            password="Test123456",
            role="student",
        )
        delete_url = reverse(UsersRoutes.ADMIN_DELETE_FULL_NAME, kwargs={"pk": removable_user.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.assertFalse(User.objects.filter(pk=removable_user.id).exists())

    def test_admin_delete_user_fail_when_user_has_booking_records(self):
        booking_user = User.objects.create_user(
            username="booking_user",
            email="booking@test.com",
            password="Test123456",
            role="student",
        )
        Booking.objects.create(
            student=booking_user,
            room=self.room,
            booking_date=date(2026, 3, 10),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="pending",
        )
        delete_url = reverse(UsersRoutes.ADMIN_DELETE_FULL_NAME, kwargs={"pk": booking_user.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data["detail"], "Cannot delete user with booking records.")
        self.assertTrue(User.objects.filter(pk=booking_user.id).exists())

    def test_admin_delete_user_fail_when_user_has_review_records(self):
        review_user = User.objects.create_user(
            username="review_user",
            email="review@test.com",
            password="Test123456",
            role="student",
        )
        booking = Booking.objects.create(
            student=review_user,
            room=self.room,
            booking_date=date(2026, 3, 11),
            start_time=time(10, 0),
            end_time=time(12, 0),
            status="approved",
        )
        Review.objects.create(
            student=review_user,
            room=self.room,
            booking=booking,
            rating=5,
            comment="Great room",
        )
        delete_url = reverse(UsersRoutes.ADMIN_DELETE_FULL_NAME, kwargs={"pk": review_user.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data["detail"], "Cannot delete user with booking records.")

    def test_admin_delete_current_logged_in_admin_fail(self):
        delete_url = reverse(UsersRoutes.ADMIN_DELETE_FULL_NAME, kwargs={"pk": self.admin_user.id})

        self.client.force_authenticate(user=self.admin_user)
        response = self.client.delete(delete_url)

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data["detail"], "You cannot delete the current logged-in admin user.")

    # students must not access the admin user management endpoints
    def test_admin_user_management_fail_for_student(self):
        self.client.force_authenticate(user=self.user)

        response = self.client.get(self.admin_user_list_url)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
