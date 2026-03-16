# keep the users app paths and route names in one place
class UsersRoutes:
    APP_NAME = "users"

    # public and authenticated user paths
    REGISTER_PATH = "register/"
    LOGIN_PATH = "login/"
    REFRESH_PATH = "refresh/"
    ME_PATH = "me/"
    CHANGE_PASSWORD_PATH = "change-password/"
    ADMIN_LIST_PATH = "admin/"
    ADMIN_CREATE_PATH = "admin/create/"
    ADMIN_UPDATE_PATH = "admin/<int:pk>/update/"
    ADMIN_DELETE_PATH = "admin/<int:pk>/delete/"

    # short route names used by django reverse
    REGISTER_NAME = "register"
    LOGIN_NAME = "login"
    REFRESH_NAME = "token_refresh"
    ME_NAME = "me"
    CHANGE_PASSWORD_NAME = "change-password"
    ADMIN_LIST_NAME = "admin-user-list"
    ADMIN_CREATE_NAME = "admin-user-create"
    ADMIN_UPDATE_NAME = "admin-user-update"
    ADMIN_DELETE_NAME = "admin-user-delete"

    # full route names with the app namespace included
    REGISTER_FULL_NAME = f"{APP_NAME}:{REGISTER_NAME}"
    LOGIN_FULL_NAME = f"{APP_NAME}:{LOGIN_NAME}"
    REFRESH_FULL_NAME = f"{APP_NAME}:{REFRESH_NAME}"
    ME_FULL_NAME = f"{APP_NAME}:{ME_NAME}"
    CHANGE_PASSWORD_FULL_NAME = f"{APP_NAME}:{CHANGE_PASSWORD_NAME}"
    ADMIN_LIST_FULL_NAME = f"{APP_NAME}:{ADMIN_LIST_NAME}"
    ADMIN_CREATE_FULL_NAME = f"{APP_NAME}:{ADMIN_CREATE_NAME}"
    ADMIN_UPDATE_FULL_NAME = f"{APP_NAME}:{ADMIN_UPDATE_NAME}"
    ADMIN_DELETE_FULL_NAME = f"{APP_NAME}:{ADMIN_DELETE_NAME}"
