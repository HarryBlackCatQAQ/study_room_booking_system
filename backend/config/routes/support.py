# keep the support app paths and route names in one place
class SupportRoutes:
    APP_NAME = "support"

    # student and admin api paths
    STUDENT_SESSION_PATH = "student/session/"
    STUDENT_MESSAGE_CREATE_PATH = "student/messages/"
    ADMIN_CONVERSATION_LIST_PATH = "admin/conversations/"
    ADMIN_CONVERSATION_DETAIL_PATH = "admin/conversations/<int:pk>/"
    ADMIN_MESSAGE_CREATE_PATH = "admin/conversations/<int:pk>/messages/"

    # short route names used by django reverse
    STUDENT_SESSION_NAME = "student-session"
    STUDENT_MESSAGE_CREATE_NAME = "student-message-create"
    ADMIN_CONVERSATION_LIST_NAME = "admin-conversation-list"
    ADMIN_CONVERSATION_DETAIL_NAME = "admin-conversation-detail"
    ADMIN_MESSAGE_CREATE_NAME = "admin-message-create"

    # full route names with the app namespace included
    STUDENT_SESSION_FULL_NAME = f"{APP_NAME}:{STUDENT_SESSION_NAME}"
    STUDENT_MESSAGE_CREATE_FULL_NAME = f"{APP_NAME}:{STUDENT_MESSAGE_CREATE_NAME}"
    ADMIN_CONVERSATION_LIST_FULL_NAME = f"{APP_NAME}:{ADMIN_CONVERSATION_LIST_NAME}"
    ADMIN_CONVERSATION_DETAIL_FULL_NAME = f"{APP_NAME}:{ADMIN_CONVERSATION_DETAIL_NAME}"
    ADMIN_MESSAGE_CREATE_FULL_NAME = f"{APP_NAME}:{ADMIN_MESSAGE_CREATE_NAME}"
