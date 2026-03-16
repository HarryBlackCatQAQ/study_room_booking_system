import logging
import time
from django.conf import settings

from config.database.state import (
    activate_database_routing_context,
    reset_read_replica_cursor,
    restore_database_routing_context,
    restore_force_primary_database_reads,
    set_force_primary_database_reads,
)


logger = logging.getLogger("api.access")


# Keep the HTTP methods that are safe to serve from read replicas.
SAFE_DATABASE_READ_METHODS = {
    "GET",
    "HEAD",
    "OPTIONS",
    "TRACE",
}


# Decide whether the current request should keep all reads on the primary database.
def should_force_primary_database_reads(request):
    # Force the primary database when the request method is unsafe and the setting is enabled.
    if (
        getattr(settings, "DB_FORCE_PRIMARY_FOR_UNSAFE_METHODS", True)
        and request.method not in SAFE_DATABASE_READ_METHODS
    ):
        return True

    # Allow an explicit query parameter to force reads to the primary database.
    if request.GET.get("use_primary_db", "").lower() in {"1", "true", "yes"}:
        return True

    # Allow an explicit header to force reads to the primary database.
    if request.headers.get("X-Use-Primary-Database", "").lower() in {"1", "true", "yes"}:
        return True

    return False


class DatabaseRoutingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    # manage the request-scoped database routing context for each http request
    def __call__(self, request):
        routing_context_token = activate_database_routing_context()
        primary_reads_token = set_force_primary_database_reads(
            should_force_primary_database_reads(request)
        )
        reset_read_replica_cursor()

        try:
            response = self.get_response(request)
        finally:
            restore_force_primary_database_reads(primary_reads_token)
            restore_database_routing_context(routing_context_token)
            reset_read_replica_cursor()

        return response


class ApiRequestLogMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    # log each api request with time, status code, and duration in milliseconds
    def __call__(self, request):
        started_at = time.perf_counter()

        try:
            response = self.get_response(request)
        except Exception:
            duration_ms = (time.perf_counter() - started_at) * 1000

            if request.path.startswith("/api/"):
                logger.exception(
                    "HTTP %s %s status=500 duration_ms=%.2f user=%s",
                    request.method,
                    request.get_full_path(),
                    duration_ms,
                    get_request_username(request),
                )

            raise

        duration_ms = (time.perf_counter() - started_at) * 1000

        if request.path.startswith("/api/"):
            logger.info(
                "HTTP %s %s status=%s duration_ms=%.2f user=%s",
                request.method,
                request.get_full_path(),
                response.status_code,
                duration_ms,
                get_request_username(request),
            )

        return response


def get_request_username(request):
    user = getattr(request, "user", None)
    if user is not None and getattr(user, "is_authenticated", False):
        return user.username

    return "anonymous"
