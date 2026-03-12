from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from config.routes import UsersRoutes

User = get_user_model()


class UserAPITests(APITestCase):
    def setUp(self):
        self.register_url = reverse(UsersRoutes.REGISTER_FULL_NAME)
        self.login_url = reverse(UsersRoutes.LOGIN_FULL_NAME)
        self.me_url = reverse(UsersRoutes.ME_FULL_NAME)
        self.change_password_url = reverse(UsersRoutes.CHANGE_PASSWORD_FULL_NAME)

        self.user = User.objects.create_user(
            username="existing_user",
            email="existing@test.com",
            password="Test123456",
            role="student",
        )

    def test_register_success(self):
        payload = {
            "username": "student1",
            "email": "student1@test.com",
            "password": "Test123456",
            "role": "student",
        }

        response = self.client.post(self.register_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(User.objects.count(), 2)
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

    def test_me_success_with_authentication(self):
        self.client.force_authenticate(user=self.user)

        response = self.client.get(self.me_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["username"], self.user.username)
        self.assertEqual(response.data["role"], self.user.role)

    def test_me_fail_without_authentication(self):
        response = self.client.get(self.me_url)

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_change_password_success(self):
        self.client.force_authenticate(user=self.user)

        payload = {
            "current_password": "Test123456",
            "new_password": "NewPass123",
            "confirm_password": "NewPass123",
        }

        response = self.client.post(self.change_password_url, payload, format="json")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["detail"], "Password changed successfully.")

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
