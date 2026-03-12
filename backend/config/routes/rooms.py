class RoomsRoutes:
    APP_NAME = "rooms"

    BUILDING_LIST_PATH = "buildings/"
    EQUIPMENT_LIST_PATH = "equipments/"
    ROOM_LIST_PATH = ""
    ROOM_DETAIL_PATH = "<int:pk>/"

    ADMIN_CREATE_PATH = "admin/create/"
    ADMIN_UPDATE_PATH = "admin/<int:pk>/update/"
    ADMIN_DELETE_PATH = "admin/<int:pk>/delete/"

    ADMIN_BUILDING_CREATE_PATH = "admin/buildings/create/"
    ADMIN_BUILDING_UPDATE_PATH = "admin/buildings/<int:pk>/update/"
    ADMIN_BUILDING_DELETE_PATH = "admin/buildings/<int:pk>/delete/"

    ADMIN_EQUIPMENT_CREATE_PATH = "admin/equipments/create/"
    ADMIN_EQUIPMENT_UPDATE_PATH = "admin/equipments/<int:pk>/update/"
    ADMIN_EQUIPMENT_DELETE_PATH = "admin/equipments/<int:pk>/delete/"

    BUILDING_LIST_NAME = "building-list"
    EQUIPMENT_LIST_NAME = "equipment-list"
    ROOM_LIST_NAME = "room-list"
    ROOM_DETAIL_NAME = "room-detail"

    ADMIN_CREATE_NAME = "admin-room-create"
    ADMIN_UPDATE_NAME = "admin-room-update"
    ADMIN_DELETE_NAME = "admin-room-delete"

    ADMIN_BUILDING_CREATE_NAME = "admin-building-create"
    ADMIN_BUILDING_UPDATE_NAME = "admin-building-update"
    ADMIN_BUILDING_DELETE_NAME = "admin-building-delete"

    ADMIN_EQUIPMENT_CREATE_NAME = "admin-equipment-create"
    ADMIN_EQUIPMENT_UPDATE_NAME = "admin-equipment-update"
    ADMIN_EQUIPMENT_DELETE_NAME = "admin-equipment-delete"

    BUILDING_LIST_FULL_NAME = f"{APP_NAME}:{BUILDING_LIST_NAME}"
    EQUIPMENT_LIST_FULL_NAME = f"{APP_NAME}:{EQUIPMENT_LIST_NAME}"
    ROOM_LIST_FULL_NAME = f"{APP_NAME}:{ROOM_LIST_NAME}"
    ROOM_DETAIL_FULL_NAME = f"{APP_NAME}:{ROOM_DETAIL_NAME}"

    ADMIN_CREATE_FULL_NAME = f"{APP_NAME}:{ADMIN_CREATE_NAME}"
    ADMIN_UPDATE_FULL_NAME = f"{APP_NAME}:{ADMIN_UPDATE_NAME}"
    ADMIN_DELETE_FULL_NAME = f"{APP_NAME}:{ADMIN_DELETE_NAME}"

    ADMIN_BUILDING_CREATE_FULL_NAME = f"{APP_NAME}:{ADMIN_BUILDING_CREATE_NAME}"
    ADMIN_BUILDING_UPDATE_FULL_NAME = f"{APP_NAME}:{ADMIN_BUILDING_UPDATE_NAME}"
    ADMIN_BUILDING_DELETE_FULL_NAME = f"{APP_NAME}:{ADMIN_BUILDING_DELETE_NAME}"

    ADMIN_EQUIPMENT_CREATE_FULL_NAME = f"{APP_NAME}:{ADMIN_EQUIPMENT_CREATE_NAME}"
    ADMIN_EQUIPMENT_UPDATE_FULL_NAME = f"{APP_NAME}:{ADMIN_EQUIPMENT_UPDATE_NAME}"
    ADMIN_EQUIPMENT_DELETE_FULL_NAME = f"{APP_NAME}:{ADMIN_EQUIPMENT_DELETE_NAME}"
