# keep the reviews app paths and route names in one place
class ReviewsRoutes:
    APP_NAME = "reviews"

    # list and create share the same base path
    LIST_CREATE_PATH = ""

    # short route name used by django reverse
    LIST_CREATE_NAME = "review-list-create"

    # full route name with the app namespace included
    LIST_CREATE_FULL_NAME = f"{APP_NAME}:{LIST_CREATE_NAME}"
