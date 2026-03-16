from django.core.management.base import BaseCommand

from bookings.services import sync_expired_pending_bookings


# management command for running the pending booking sync by hand
class Command(BaseCommand):
    help = "Sync expired pending bookings and reject the ones that have already missed their booking time."

    # run the expired pending booking sync manually
    def handle(self, *args, **options):
        updated_count = sync_expired_pending_bookings(force=True)
        self.stdout.write(
            self.style.SUCCESS(
                f"Synced expired pending bookings successfully. Updated {updated_count} booking(s)."
            )
        )
