from collections import defaultdict
from datetime import datetime, timedelta
import random

from django.core.management.base import BaseCommand, CommandError
from django.db import transaction
from django.utils import timezone

from bookings.management.commands.generate_demo_data import Command as DemoDataCommand
from bookings.models import Booking
from reviews.models import Review
from rooms.models import Room
from support.models import SupportConversation, SupportMessage
from users.models import User


# student message templates used to expand the main support thread
STUDENT_SUPPORT_LINES = [
    "I am checking whether there are any quieter rooms available later this week.",
    "Could you help confirm if my updated booking history looks correct?",
    "I want to make sure the approved room still has the listed equipment.",
    "My group may need a slightly larger room for the next study session.",
    "I am reviewing older bookings and wanted to double check one of the room details.",
    "Can you suggest another room near the library with a screen?",
]

# admin message templates used to expand the main support thread
ADMIN_SUPPORT_LINES = [
    "I checked the booking record and everything is still active on our side.",
    "The room list has several similar spaces available in the same time window.",
    "I reviewed the equipment details and the room record is up to date.",
    "Your booking history is stored correctly and should load after a refresh.",
    "There are a few larger rooms that match the same study requirements.",
    "The support queue has been updated and your latest request is visible to admins.",
]


class Command(BaseCommand):
    help = "Boost the main student/admin test accounts with richer related data."

    # add command line options so the target sizes can be changed
    def add_arguments(self, parser):
        parser.add_argument("--student-username", default="student1")
        parser.add_argument("--admin-username", default="admin")
        parser.add_argument("--target-student-bookings", type=int, default=300)
        parser.add_argument("--target-student-reviews", type=int, default=100)
        parser.add_argument("--target-admin-processed-bookings", type=int, default=300)
        parser.add_argument("--target-student-support-messages", type=int, default=50)
        parser.add_argument("--target-admin-support-messages", type=int, default=90)
        parser.add_argument("--seed", type=int, default=20260315)

    # top up bookings, reviews, and support data for the main demo accounts
    def handle(self, *args, **options):
        rng = random.Random(options["seed"])
        helper = DemoDataCommand()

        try:
            student = User.objects.get(username=options["student_username"])
        except User.DoesNotExist as exc:
            raise CommandError(f"Student user '{options['student_username']}' was not found.") from exc

        try:
            admin = User.objects.get(username=options["admin_username"])
        except User.DoesNotExist as exc:
            raise CommandError(f"Admin user '{options['admin_username']}' was not found.") from exc

        with transaction.atomic():
            created_bookings = self.ensure_student_and_admin_bookings(
                student=student,
                admin=admin,
                target_student_bookings=options["target_student_bookings"],
                target_admin_processed_bookings=options["target_admin_processed_bookings"],
                target_student_reviews=options["target_student_reviews"],
                rng=rng,
                helper=helper,
            )
            created_reviews = self.ensure_student_reviews(
                student=student,
                target_student_reviews=options["target_student_reviews"],
                rng=rng,
                helper=helper,
            )
            created_support_messages = self.ensure_support_thread(
                student=student,
                admin=admin,
                target_student_support_messages=options["target_student_support_messages"],
                target_admin_support_messages=options["target_admin_support_messages"],
                rng=rng,
            )

        summary = {
            "student_bookings": Booking.objects.filter(student=student).count(),
            "student_reviews": Review.objects.filter(student=student).count(),
            "student_support_messages": SupportMessage.objects.filter(sender=student).count(),
            "admin_processed_bookings": Booking.objects.filter(processed_by=admin).count(),
            "admin_support_messages": SupportMessage.objects.filter(sender=admin).count(),
        }

        self.stdout.write(self.style.SUCCESS("Primary account data boost completed."))
        self.stdout.write(f"Created bookings: {created_bookings}")
        self.stdout.write(f"Created reviews: {created_reviews}")
        self.stdout.write(f"Created support messages: {created_support_messages}")
        self.stdout.write(self.style.SUCCESS(f"Current primary account totals: {summary}"))

    # create enough bookings to meet the student, admin, and review targets
    def ensure_student_and_admin_bookings(
        self,
        student,
        admin,
        target_student_bookings,
        target_admin_processed_bookings,
        target_student_reviews,
        rng,
        helper,
    ):
        current_student_bookings = Booking.objects.filter(student=student).count()
        current_admin_processed = Booking.objects.filter(processed_by=admin).count()
        current_student_reviews = Review.objects.filter(student=student).count()
        current_eligible_reviews = self.count_unreviewed_past_approved_bookings(student)

        student_booking_gap = max(0, target_student_bookings - current_student_bookings)
        admin_processed_gap = max(0, target_admin_processed_bookings - current_admin_processed)
        review_eligibility_gap = max(
            0,
            target_student_reviews - (current_student_reviews + current_eligible_reviews),
        )

        total_new_bookings = max(student_booking_gap, admin_processed_gap, review_eligibility_gap)
        if total_new_bookings <= 0:
            return 0

        processed_bookings = min(
            total_new_bookings,
            max(admin_processed_gap, review_eligibility_gap),
        )

        past_approved_count = min(
            processed_bookings,
            max(review_eligibility_gap, min(140, processed_bookings // 2 or processed_bookings)),
        )
        remaining_processed = processed_bookings - past_approved_count
        future_approved_count = int(remaining_processed * 0.72)
        rejected_count = remaining_processed - future_approved_count

        other_count = total_new_bookings - processed_bookings
        pending_count = int(other_count * 0.58)
        cancelled_count = other_count - pending_count

        active_rooms = list(Room.objects.filter(is_active=True).order_by("id"))
        if not active_rooms:
            raise CommandError("No active rooms are available to generate primary account bookings.")

        popular_rooms = rng.sample(active_rooms, k=max(1, min(14, len(active_rooms))))
        occupied_slots = defaultdict(list)
        for room_id, booking_date, start_time_value, end_time_value in Booking.objects.filter(
            status__in=["pending", "approved"]
        ).values_list("room_id", "booking_date", "start_time", "end_time"):
            occupied_slots[(room_id, booking_date)].append(
                (helper.time_to_minutes(start_time_value), helper.time_to_minutes(end_time_value))
            )

        for intervals in occupied_slots.values():
            intervals.sort()

        plans = [
            ("approved_past", past_approved_count),
            ("approved_future", future_approved_count),
            ("rejected", rejected_count),
            ("pending", pending_count),
            ("cancelled", cancelled_count),
        ]

        created = 0
        for plan_status, plan_count in plans:
            attempts = 0
            created_for_plan = 0

            while created_for_plan < plan_count and attempts < plan_count * 40:
                attempts += 1
                room = rng.choice(popular_rooms) if rng.random() < 0.6 else rng.choice(active_rooms)
                booking_date = self.pick_booking_date_for_primary(plan_status, rng)
                start_minutes, end_minutes = helper.pick_time_slot(rng)

                if plan_status in {"approved_past", "approved_future", "pending"}:
                    day_slots = occupied_slots[(room.id, booking_date)]
                    if helper.has_conflict(day_slots, start_minutes, end_minutes):
                        continue
                    day_slots.append((start_minutes, end_minutes))
                    day_slots.sort()

                final_status = "approved" if plan_status.startswith("approved") else plan_status
                processed_by = admin if final_status in {"approved", "rejected"} else None

                booking = Booking.objects.create(
                    student=student,
                    room=room,
                    booking_date=booking_date,
                    start_time=helper.minutes_to_time(start_minutes),
                    end_time=helper.minutes_to_time(end_minutes),
                    status=final_status,
                    processed_by=processed_by,
                )

                created_at = helper.pick_booking_created_at(
                    booking_date,
                    start_minutes,
                    final_status,
                    rng,
                )
                Booking.objects.filter(pk=booking.pk).update(created_at=created_at)
                created += 1
                created_for_plan += 1

            if created_for_plan < plan_count:
                raise CommandError(
                    f"Only created {created_for_plan} of {plan_count} planned '{plan_status}' bookings."
                )

        return created

    # create review records for the main student account
    def ensure_student_reviews(self, student, target_student_reviews, rng, helper):
        current_reviews = Review.objects.filter(student=student).count()
        missing = max(0, target_student_reviews - current_reviews)
        if missing <= 0:
            return 0

        now = timezone.now()
        eligible_bookings = []
        queryset = (
            Booking.objects.filter(student=student, status="approved", review__isnull=True)
            .select_related("room")
            .order_by("booking_date", "start_time")
        )

        for booking in queryset:
            booking_end = helper.make_aware(datetime.combine(booking.booking_date, booking.end_time))
            if booking_end < now:
                eligible_bookings.append((booking, booking_end))

        if len(eligible_bookings) < missing:
            raise CommandError(
                f"Not enough approved student bookings to create {missing} new reviews."
            )

        rng.shuffle(eligible_bookings)
        created = 0

        for booking, booking_end in eligible_bookings[:missing]:
            rating = rng.choices([5, 4, 3, 2, 1], weights=[34, 38, 17, 7, 4], k=1)[0]
            review = Review.objects.create(
                student=student,
                room=booking.room,
                booking=booking,
                rating=rating,
                comment=helper.build_review_comment(rating, booking.room, rng),
            )

            created_at = booking_end + timedelta(
                hours=rng.randint(2, 72),
                days=rng.randint(0, 8),
            )
            if created_at >= now:
                created_at = now - timedelta(hours=rng.randint(1, 24))

            Review.objects.filter(pk=review.pk).update(created_at=created_at)
            created += 1

        return created

    # expand the shared support thread between the main student and admin accounts
    def ensure_support_thread(
        self,
        student,
        admin,
        target_student_support_messages,
        target_admin_support_messages,
        rng,
    ):
        current_student_messages = SupportMessage.objects.filter(sender=student).count()
        current_admin_messages = SupportMessage.objects.filter(sender=admin).count()

        student_gap = max(0, target_student_support_messages - current_student_messages)
        admin_gap = max(0, target_admin_support_messages - current_admin_messages)
        if student_gap <= 0 and admin_gap <= 0:
            return 0

        conversation = (
            SupportConversation.objects.filter(student=student, assigned_admin=admin)
            .order_by("-last_message_at", "-id")
            .first()
        )
        if conversation is None:
            conversation = SupportConversation.objects.create(
                student=student,
                assigned_admin=admin,
                status="open",
            )

        SupportConversation.objects.filter(pk=conversation.pk).update(
            assigned_admin=admin,
            status="open",
        )
        SupportMessage.objects.filter(
            conversation=conversation,
            sender__role="student",
            is_read_by_admin=False,
        ).update(is_read_by_admin=True)
        SupportMessage.objects.filter(
            conversation=conversation,
            sender__role="admin",
            is_read_by_student=False,
        ).update(is_read_by_student=True)

        message_roles = self.build_message_role_plan(student_gap, admin_gap)
        if not message_roles:
            return 0

        now = timezone.now()
        start_at = now - timedelta(minutes=(len(message_roles) + 6) * 6)
        if conversation.last_message_at:
            start_at = max(start_at, conversation.last_message_at + timedelta(minutes=2))

        current_time = start_at
        created = 0

        for index, role in enumerate(message_roles):
            sender = student if role == "student" else admin
            line_pool = STUDENT_SUPPORT_LINES if role == "student" else ADMIN_SUPPORT_LINES
            content = line_pool[index % len(line_pool)]
            is_last = index == len(message_roles) - 1

            message = SupportMessage.objects.create(
                conversation=conversation,
                sender=sender,
                content=content,
                is_read_by_student=True,
                is_read_by_admin=True,
            )

            current_time = min(now - timedelta(minutes=1), current_time + timedelta(minutes=6))
            is_read_by_student = True
            is_read_by_admin = True

            if is_last:
                if role == "student":
                    is_read_by_admin = False
                else:
                    is_read_by_student = False

            SupportMessage.objects.filter(pk=message.pk).update(
                created_at=current_time,
                is_read_by_student=is_read_by_student,
                is_read_by_admin=is_read_by_admin,
            )
            created += 1

        SupportConversation.objects.filter(pk=conversation.pk).update(
            assigned_admin=admin,
            status="open",
            last_message_at=current_time,
            updated_at=current_time,
        )

        return created

    # decide the order of student and admin support messages
    def build_message_role_plan(self, student_gap, admin_gap):
        plan = []
        next_role = "student" if student_gap >= admin_gap else "admin"

        while student_gap > 0 or admin_gap > 0:
            if next_role == "student" and student_gap > 0:
                plan.append("student")
                student_gap -= 1
                next_role = "admin"
                continue

            if next_role == "admin" and admin_gap > 0:
                plan.append("admin")
                admin_gap -= 1
                next_role = "student"
                continue

            if student_gap > 0:
                plan.append("student")
                student_gap -= 1
                continue

            if admin_gap > 0:
                plan.append("admin")
                admin_gap -= 1

        return plan

    # count approved student bookings that can still receive a review
    def count_unreviewed_past_approved_bookings(self, student):
        count = 0
        now = timezone.now()

        for booking_date, end_time_value in Booking.objects.filter(
            student=student,
            status="approved",
            review__isnull=True,
        ).values_list("booking_date", "end_time"):
            booking_end = timezone.make_aware(datetime.combine(booking_date, end_time_value))
            if booking_end < now:
                count += 1

        return count

    # choose a booking date that matches the requested primary-account scenario
    def pick_booking_date_for_primary(self, status, rng):
        today = timezone.localdate()

        if status == "approved_past":
            return today - timedelta(days=rng.randint(3, 160))
        if status == "approved_future":
            return today + timedelta(days=rng.randint(2, 35))
        if status == "pending":
            return today + timedelta(days=rng.randint(1, 24))
        if status == "rejected":
            return today + timedelta(days=rng.randint(-40, 28))
        return today + timedelta(days=rng.randint(-28, 36))
