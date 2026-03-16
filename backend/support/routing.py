# define websocket urls for student and admin support chat
from django.urls import path

from .consumers import AdminSupportConsumer, StudentSupportConsumer


websocket_urlpatterns = [
    # websocket endpoint for the student support drawer
    path('ws/support/student/', StudentSupportConsumer.as_asgi()),
    # websocket endpoint for the admin support dashboard
    path('ws/support/admin/', AdminSupportConsumer.as_asgi()),
]
