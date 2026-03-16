import logging

import grpc
import study_room_services_pb2 as pb
import study_room_services_pb2_grpc as pb_grpc

from django.conf import settings
from django.core.cache import cache
from django.db.models import Q
from django.utils import timezone

from .models import Booking

logger = logging.getLogger(__name__)

PENDING_SYNC_LOCK_KEY = "bookings:expired_pending:lock"
PENDING_SYNC_LOCK_TIMEOUT = 15


# sync the expired pending bookings before returning booking data to the user
def sync_expired_pending_bookings(force=False):
    lock_acquired = acquire_sync_lock()
    if not lock_acquired:
        return 0

    try:
        now = timezone.localtime()
        pending_bookings = list(get_expired_pending_candidates(now))

        if not pending_bookings:
            return 0

        expired_booking_ids = find_expired_pending_booking_ids(pending_bookings, now)
        if not expired_booking_ids:
            return 0

        updated_count = Booking.objects.filter(
            id__in=expired_booking_ids,
            status="pending",
        ).update(
            status="rejected",
            processed_by=None,
        )

        return updated_count
    finally:
        release_sync_lock()


# return the pending bookings that have already passed their booking start time
def get_expired_pending_candidates(now):
    current_date = now.date()
    current_time = now.time()

    return Booking.objects.filter(status="pending").filter(
        Q(booking_date__lt=current_date)
        | Q(
            booking_date=current_date,
            start_time__lte=current_time,
        )
    )


# call the java service to decide which pending bookings should be rejected automatically
def find_expired_pending_booking_ids(bookings, now):
    grpc_request = pb.ExpiredPendingBookingsRequest(
        current_date=now.date().isoformat(),
        current_time=now.strftime("%H:%M"),
        bookings=[pending_booking_to_proto(booking) for booking in bookings],
    )

    grpc_target = getattr(
        settings,
        "JAVA_BOOKING_LIFECYCLE_GRPC_TARGET",
        settings.JAVA_RECOMMENDATION_GRPC_TARGET,
    )

    try:
        with grpc.insecure_channel(grpc_target) as channel:
            stub = pb_grpc.BookingLifecycleServiceStub(channel)
            grpc_response = stub.FindExpiredPendingBookings(grpc_request, timeout=5)

        return list(grpc_response.expired_booking_ids)
    except grpc.RpcError as exc:
        # fallback to local calculation if the java service is temporarily unavailable
        logger.warning(
            "Failed to call the java booking lifecycle service (%s). Falling back to local calculation.",
            exc.code().name,
        )
        return find_expired_pending_booking_ids_locally(bookings, now)


# convert one pending booking into the proto message used by the java service
def pending_booking_to_proto(booking):
    return pb.PendingBookingSnapshot(
        booking_id=booking.id,
        booking_date=booking.booking_date.isoformat(),
        start_time=booking.start_time.strftime("%H:%M"),
        status=booking.status,
    )


# use the same expiry rule locally so the system still works even if the java service is down
def find_expired_pending_booking_ids_locally(bookings, now):
    expired_booking_ids = []
    current_date = now.date()
    current_time = now.time()

    for booking in bookings:
        if booking.status != "pending":
            continue

        if booking.booking_date < current_date:
            expired_booking_ids.append(booking.id)
            continue

        if booking.booking_date == current_date and booking.start_time <= current_time:
            expired_booking_ids.append(booking.id)

    return expired_booking_ids


# use redis cache as a lock to avoid repeated concurrent sync runs
def acquire_sync_lock():
    try:
        return cache.add(PENDING_SYNC_LOCK_KEY, "1", timeout=PENDING_SYNC_LOCK_TIMEOUT)
    except Exception:
        logger.warning("Failed to acquire the expired booking sync lock.", exc_info=True)
        return True


# release the sync lock when the sync finishes
def release_sync_lock():
    try:
        cache.delete(PENDING_SYNC_LOCK_KEY)
    except Exception:
        logger.warning("Failed to release the expired booking sync lock.", exc_info=True)
