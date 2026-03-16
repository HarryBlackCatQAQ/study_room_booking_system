from rest_framework.permissions import BasePermission


# custom permission class to check if the user is a student
class IsRoleStudent(BasePermission):
    # allow access only when the current user is an authenticated student
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == 'student'
