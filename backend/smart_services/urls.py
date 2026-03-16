from django.urls import path
from .views import RoomRecommendationView, AvailabilitySearchView

urlpatterns = [
    # add the url for the room recommendation (gRPC Java)
    path("recommendations/", RoomRecommendationView.as_view(), name="room-recommendations"),


    # add the url for the availability search (gRPC Go)
    path("available-slots/", AvailabilitySearchView.as_view(), name="available-slots"),
]
