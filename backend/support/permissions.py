from rest_framework.permissions import BasePermission


# custom permission class to check if the user is a student
class IsRoleStudent(BasePermission):
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == 'student'

