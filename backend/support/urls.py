from django.urls import path

from config.routes import SupportRoutes

from .views import (
    AdminSupportConversationDetailView,
    AdminSupportConversationListView,
    AdminSupportMessageCreateView,
    StudentSupportMessageCreateView,
    StudentSupportSessionView,
)

app_name = SupportRoutes.APP_NAME

urlpatterns = [
    # add the url for the student to start or get the current support session
    path(
        SupportRoutes.STUDENT_SESSION_PATH,
        StudentSupportSessionView.as_view(),
        name=SupportRoutes.STUDENT_SESSION_NAME,
    ),

    # add the url for the student to send a support message
    path(
        SupportRoutes.STUDENT_MESSAGE_CREATE_PATH,
        StudentSupportMessageCreateView.as_view(),
        name=SupportRoutes.STUDENT_MESSAGE_CREATE_NAME,
    ),

    # add the url for the admin to list support conversations
    path(
        SupportRoutes.ADMIN_CONVERSATION_LIST_PATH,
        AdminSupportConversationListView.as_view(),
        name=SupportRoutes.ADMIN_CONVERSATION_LIST_NAME,
    ),

    # add the url for the admin to get a support conversation detail
    path(
        SupportRoutes.ADMIN_CONVERSATION_DETAIL_PATH,
        AdminSupportConversationDetailView.as_view(),
        name=SupportRoutes.ADMIN_CONVERSATION_DETAIL_NAME,
    ),

    # add the url for the admin to reply to a support conversation
    path(
        SupportRoutes.ADMIN_MESSAGE_CREATE_PATH,
        AdminSupportMessageCreateView.as_view(),
        name=SupportRoutes.ADMIN_MESSAGE_CREATE_NAME,
    ),
]
