class ApiPrefix:
    AUTH = "api/auth/"
    ROOMS = "api/rooms/"
    BOOKINGS = "api/bookings/"
    REVIEWS = "api/reviews/"


class UsersRoutes:
    APP_NAME = "users"

    REGISTER_PATH = "register/"
    LOGIN_PATH = "login/"
    REFRESH_PATH = "refresh/"
    ME_PATH = "me/"

    REGISTER_NAME = "register"
    LOGIN_NAME = "login"
    REFRESH_NAME = "token_refresh"
    ME_NAME = "me"

    REGISTER_FULL_NAME = f"{APP_NAME}:{REGISTER_NAME}"
    LOGIN_FULL_NAME = f"{APP_NAME}:{LOGIN_NAME}"
    REFRESH_FULL_NAME = f"{APP_NAME}:{REFRESH_NAME}"
    ME_FULL_NAME = f"{APP_NAME}:{ME_NAME}"


class RoomsRoutes:
    APP_NAME = "rooms"

    BUILDING_LIST_PATH = "buildings/"
    ROOM_LIST_PATH = ""
    ROOM_DETAIL_PATH = "<int:pk>/"
    ADMIN_CREATE_PATH = "admin/create/"
    ADMIN_UPDATE_PATH = "admin/<int:pk>/update/"
    ADMIN_DELETE_PATH = "admin/<int:pk>/delete/"

    BUILDING_LIST_NAME = "building-list"
    ROOM_LIST_NAME = "room-list"
    ROOM_DETAIL_NAME = "room-detail"
    ADMIN_CREATE_NAME = "admin-room-create"
    ADMIN_UPDATE_NAME = "admin-room-update"
    ADMIN_DELETE_NAME = "admin-room-delete"

    BUILDING_LIST_FULL_NAME = f"{APP_NAME}:{BUILDING_LIST_NAME}"
    ROOM_LIST_FULL_NAME = f"{APP_NAME}:{ROOM_LIST_NAME}"
    ROOM_DETAIL_FULL_NAME = f"{APP_NAME}:{ROOM_DETAIL_NAME}"
    ADMIN_CREATE_FULL_NAME = f"{APP_NAME}:{ADMIN_CREATE_NAME}"
    ADMIN_UPDATE_FULL_NAME = f"{APP_NAME}:{ADMIN_UPDATE_NAME}"
    ADMIN_DELETE_FULL_NAME = f"{APP_NAME}:{ADMIN_DELETE_NAME}"


class BookingsRoutes:
    APP_NAME = "bookings"

    CREATE_PATH = ""
    MY_LIST_PATH = "my/"
    CANCEL_PATH = "<int:pk>/cancel/"
    ADMIN_LIST_PATH = "admin/all/"
    APPROVE_PATH = "admin/<int:pk>/approve/"
    REJECT_PATH = "admin/<int:pk>/reject/"

    CREATE_NAME = "booking-create"
    MY_LIST_NAME = "my-bookings"
    CANCEL_NAME = "booking-cancel"
    ADMIN_LIST_NAME = "admin-booking-list"
    APPROVE_NAME = "booking-approve"
    REJECT_NAME = "booking-reject"

    CREATE_FULL_NAME = f"{APP_NAME}:{CREATE_NAME}"
    MY_LIST_FULL_NAME = f"{APP_NAME}:{MY_LIST_NAME}"
    CANCEL_FULL_NAME = f"{APP_NAME}:{CANCEL_NAME}"
    ADMIN_LIST_FULL_NAME = f"{APP_NAME}:{ADMIN_LIST_NAME}"
    APPROVE_FULL_NAME = f"{APP_NAME}:{APPROVE_NAME}"
    REJECT_FULL_NAME = f"{APP_NAME}:{REJECT_NAME}"


class ReviewsRoutes:
    APP_NAME = "reviews"

    LIST_CREATE_PATH = ""

    LIST_CREATE_NAME = "review-list-create"

    LIST_CREATE_FULL_NAME = f"{APP_NAME}:{LIST_CREATE_NAME}"