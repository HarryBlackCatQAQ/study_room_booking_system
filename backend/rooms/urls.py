from django.urls import path
from .views import (
    BuildingListView,
    RoomListView,
    RoomDetailView,
    AdminRoomCreateView,
    AdminRoomUpdateView,
    AdminRoomDeleteView,
)

from config.routes import RoomsRoutes

app_name = RoomsRoutes.APP_NAME

urlpatterns = [
    # add the url for the building list
    path(RoomsRoutes.BUILDING_LIST_PATH, BuildingListView.as_view(), name=RoomsRoutes.BUILDING_LIST_NAME),

    # add the url for the room list
    path(RoomsRoutes.ROOM_LIST_PATH, RoomListView.as_view(), name=RoomsRoutes.ROOM_LIST_NAME),

    # add the url for the room detail, passing the room ID in the URL
    path(RoomsRoutes.ROOM_DETAIL_PATH, RoomDetailView.as_view(), name=RoomsRoutes.ROOM_DETAIL_NAME),

    # add the url for the admin room create
    path(RoomsRoutes.ADMIN_CREATE_PATH, AdminRoomCreateView.as_view(), name=RoomsRoutes.ADMIN_CREATE_NAME),

    # add the url for the admin room update, passing the room ID in the URLs
    path(RoomsRoutes.ADMIN_UPDATE_PATH, AdminRoomUpdateView.as_view(), name=RoomsRoutes.ADMIN_UPDATE_NAME),

    # add the url for the admin room delete, passing the room ID in the URLs
    path(RoomsRoutes.ADMIN_DELETE_PATH, AdminRoomDeleteView.as_view(), name=RoomsRoutes.ADMIN_DELETE_NAME),
]