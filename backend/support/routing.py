from django.urls import path

from .consumers import AdminSupportConsumer, StudentSupportConsumer


websocket_urlpatterns = [
    path('ws/support/student/', StudentSupportConsumer.as_asgi()),
    path('ws/support/admin/', AdminSupportConsumer.as_asgi()),
]
