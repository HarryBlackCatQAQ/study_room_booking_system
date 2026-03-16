from collections import Counter, defaultdict
from datetime import datetime, time, timedelta
import random

from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone

from bookings.models import Booking
from reviews.models import Review
from rooms.models import Building, Equipment, Room
from support.models import SupportConversation, SupportMessage
from users.models import User


# default password used for generated demo accounts
DEFAULT_PASSWORD = "StudyNest123!"
# default random seed so demo data stays repeatable
DEFAULT_SEED = 20260315

# target record counts for each demo dataset area
TARGETS = {
    "admins": 6,
    "students": 160,
    "buildings": 12,
    "equipment": 18,
    "rooms": 78,
    "bookings": 680,
    "reviews": 260,
    "support_conversations": 54,
    "support_messages": 320,
}

# first names used when building demo student accounts
FIRST_NAMES = [
    "Alex",
    "Amelia",
    "Ava",
    "Benjamin",
    "Callum",
    "Chloe",
    "Daniel",
    "Eleanor",
    "Ella",
    "Emily",
    "Ethan",
    "Eva",
    "Grace",
    "Hannah",
    "Harry",
    "Isla",
    "Jack",
    "James",
    "Leo",
    "Lewis",
    "Liam",
    "Lucas",
    "Mason",
    "Mia",
    "Noah",
    "Oliver",
    "Olivia",
    "Oscar",
    "Ruby",
    "Sophie",
    "Thea",
    "Thomas",
    "William",
    "Zoe",
]

# last names used when building demo student accounts
LAST_NAMES = [
    "Anderson",
    "Bailey",
    "Brown",
    "Campbell",
    "Carter",
    "Clark",
    "Davies",
    "Edwards",
    "Evans",
    "Foster",
    "Graham",
    "Grant",
    "Hall",
    "Hamilton",
    "Hughes",
    "Jackson",
    "Kelly",
    "Lewis",
    "MacDonald",
    "Martin",
    "Mitchell",
    "Morris",
    "Patel",
    "Reid",
    "Roberts",
    "Scott",
    "Smith",
    "Taylor",
    "Thompson",
    "Walker",
    "Watson",
    "Wilson",
    "Young",
]

# fixed admin accounts that should always exist in the demo dataset
ADMIN_SPECS = [
    ("admin_ops_01", "Campus", "Operations"),
    ("admin_rooms_02", "Megan", "Stewart"),
    ("admin_support_03", "Daniel", "McLean"),
    ("admin_services_04", "Priya", "Patel"),
    ("admin_review_05", "Oliver", "Fraser"),
    ("admin_facilities_06", "Chloe", "Murray"),
    ("admin_queue_07", "Lewis", "Campbell"),
    ("admin_records_08", "Amelia", "Grant"),
]

# fixed building records used by the demo dataset
BUILDING_SPECS = [
    ("Anderson Library", "Main Campus", "08:00-22:00"),
    ("Teaching and Learning Centre", "Main Campus", "08:00-21:30"),
    ("Adam Smith Building", "Main Campus", "08:30-20:00"),
    ("Rankine Building", "West End Campus", "08:00-22:00"),
    ("St Andrews Building", "West End Campus", "08:00-21:00"),
    ("Engineering Research Centre", "North Campus", "07:30-22:30"),
    ("Kelvin Hall Study Centre", "West End Campus", "09:00-21:00"),
    ("Wolfson Medical Building", "South Campus", "07:00-20:30"),
    ("Riverside Learning Commons", "Riverside Campus", "08:00-23:00"),
    ("Advanced Materials Hub", "North Campus", "08:00-20:00"),
    ("Student Union Learning Loft", "Main Campus", "09:00-23:59"),
    ("Innovation and Design Studio", "North Campus", "08:00-22:00"),
    ("Library Annexe", "Main Campus", "08:00-22:00"),
    ("Digital Scholarship Centre", "Riverside Campus", "08:00-21:00"),
]

# equipment names that can be attached to generated rooms
EQUIPMENT_NAMES = [
    "Whiteboard",
    "Projector",
    "HDMI Display",
    "Dual Monitors",
    "Video Conferencing",
    "Power Sockets",
    "Moveable Tables",
    "Smart Screen",
    "Lecture Capture",
    "Accessible Desk",
    "Air Purifier",
    "Acoustic Panels",
    "Printer Access",
    "Window Blinds",
    "Height Adjustable Desk",
    "USB-C Dock",
    "Portable Speaker",
    "Document Camera",
    "Task Lighting",
    "Laptop Charging Locker",
]

# room type templates used to build room names and capacities
ROOM_TYPE_SPECS = [
    ("Quiet Pod", 2, 4),
    ("Study Room", 4, 8),
    ("Collaboration Suite", 6, 12),
    ("Seminar Room", 10, 18),
    ("Project Room", 8, 14),
    ("Focus Booth", 1, 2),
    ("Workshop Room", 12, 24),
]

# simple building wing names used in generated room locations
WINGS = ["East", "West", "North", "South", "Central"]
EQUIPMENT_STATUSES = ["available", "available", "available", "available", "maintenance", "limited"]

# sentence starters used to build realistic review comments
REVIEW_OPENERS = {
    5: [
        "Excellent room for revision.",
        "Very smooth booking experience.",
        "Great study space for a group session.",
        "Quiet room with everything we needed.",
    ],
    4: [
        "Solid room overall.",
        "Good option for a project meeting.",
        "Comfortable space for a study block.",
        "Useful room and easy to find.",
    ],
    3: [
        "The room was acceptable.",
        "A decent option for short sessions.",
        "The booking worked but the room was average.",
    ],
    2: [
        "The room was usable but had some issues.",
        "Not ideal for a long session.",
    ],
    1: [
        "The room did not meet expectations.",
        "This booking was frustrating to use.",
    ],
}

REVIEW_DETAILS = {
    "positive": [
        "The equipment list matched what was available on arrival.",
        "There were enough sockets and seating for everyone in the group.",
        "The room stayed quiet for the full session.",
        "The location was convenient between classes.",
        "The layout worked well for both laptops and discussion.",
    ],
    "mixed": [
        "The room was fine, although it felt a little cramped at peak time.",
        "The booking itself was easy, but the space could be cleaner.",
        "It worked for the session, though the setup was only average.",
        "The room was usable, but the ventilation could be better.",
    ],
    "negative": [
        "The space felt noisy compared with similar rooms nearby.",
        "A few of the facilities listed online were not ready when we arrived.",
        "The room was harder to access than expected during a busy period.",
        "It worked in the end, but the setup did not suit group work.",
    ],
}

# support chat topic pairs used to build demo conversations
SUPPORT_TOPICS = [
    {
        "student": [
            "I cannot find a quiet room near the library for tomorrow afternoon.",
            "Could someone recommend a room with a screen for a group meeting?",
            "I need help finding a room for a revision session later this week.",
        ],
        "admin": [
            "I checked the current room list and there are still several available options nearby.",
            "You should be able to filter for larger rooms with display equipment on the rooms page.",
            "I have reviewed the inventory and there are suitable spaces available for that time window.",
        ],
    },
    {
        "student": [
            "My approved booking is not showing clearly in my booking list.",
            "I received an approval earlier but I want to confirm the room and time again.",
            "Could you help me verify whether my reservation is still active?",
        ],
        "admin": [
            "I checked the booking record and the reservation is still active in the system.",
            "Please refresh the page and the booking should appear with the latest status.",
            "The booking is valid and the room remains assigned to your request.",
        ],
    },
    {
        "student": [
            "The room I used today did not have the equipment I expected.",
            "The equipment list for this room seems different from what I saw onsite.",
            "Could the equipment details for this room be checked?",
        ],
        "admin": [
            "I have flagged the room record for an equipment review.",
            "The facilities team has been asked to verify the listed equipment.",
            "We will update the equipment information if anything is inaccurate.",
        ],
    },
    {
        "student": [
            "I need a slightly larger room for a project meeting next week.",
            "Can my current request be compared with other rooms that fit more students?",
            "I am looking for another room with more seats and a whiteboard.",
        ],
        "admin": [
            "There are a few larger rooms with similar equipment available in the next booking window.",
            "I can suggest rooms with higher capacity if your group size has changed.",
            "The admin team can review the options and point you to similar rooms.",
        ],
    },
]


class Command(BaseCommand):
    help = "Generate realistic demo data directly into the configured database."

    # add command line options so the seed and password can be changed
    def add_arguments(self, parser):
        parser.add_argument("--seed", type=int, default=DEFAULT_SEED)
        parser.add_argument("--password", default=DEFAULT_PASSWORD)

    # run the full demo data generation flow inside one database transaction
    def handle(self, *args, **options):
        rng = random.Random(options["seed"])
        password = options["password"]

        with transaction.atomic():
            admins, students, user_created = self.ensure_users(rng, password)
            buildings, building_created = self.ensure_buildings()
            equipment, equipment_created = self.ensure_equipment(rng)
            rooms, room_created = self.ensure_rooms(rng, buildings, equipment)
            bookings_created = self.ensure_bookings(rng, students, admins, rooms)
            reviews_created = self.ensure_reviews(rng)
            conversations_created, messages_created = self.ensure_support_data(rng, students, admins)

        summary = {
            "users": User.objects.count(),
            "admins": User.objects.filter(role="admin").count(),
            "students": User.objects.filter(role="student").count(),
            "buildings": Building.objects.count(),
            "equipment": Equipment.objects.count(),
            "rooms": Room.objects.count(),
            "bookings": Booking.objects.count(),
            "reviews": Review.objects.count(),
            "support_conversations": SupportConversation.objects.count(),
            "support_messages": SupportMessage.objects.count(),
        }

        self.stdout.write(self.style.SUCCESS("Demo data generation completed for the configured database."))
        self.stdout.write(f"Generated users: {user_created}")
        self.stdout.write(f"Generated buildings: {building_created}")
        self.stdout.write(f"Generated equipment records: {equipment_created}")
        self.stdout.write(f"Generated rooms: {room_created}")
        self.stdout.write(f"Generated bookings: {bookings_created}")
        self.stdout.write(f"Generated reviews: {reviews_created}")
        self.stdout.write(f"Generated support conversations: {conversations_created}")
        self.stdout.write(f"Generated support messages: {messages_created}")
        self.stdout.write(f"Generated account password: {password}")
        self.stdout.write(self.style.SUCCESS(f"Current totals: {summary}"))

    # make sure the needed admin and student accounts exist
    def ensure_users(self, rng, password):
        created = 0
        existing_usernames = set(User.objects.values_list("username", flat=True))
        admins = list(User.objects.filter(role="admin").order_by("id"))
        students = list(User.objects.filter(role="student").order_by("id"))

        for username, first_name, last_name in ADMIN_SPECS:
            if len(admins) >= TARGETS["admins"]:
                break
            if username in existing_usernames:
                continue

            user = User(
                username=username,
                email=f"{username}@studynest.local",
                first_name=first_name,
                last_name=last_name,
                role="admin",
                is_staff=True,
                is_active=True,
            )
            user.set_password(password)
            user.save()

            joined_at = self.random_past_datetime(rng, min_days=60, max_days=420)
            User.objects.filter(pk=user.pk).update(date_joined=joined_at)
            user.date_joined = joined_at

            admins.append(user)
            existing_usernames.add(username)
            created += 1

        student_sequence = 1
        while len(students) < TARGETS["students"]:
            username = f"student_{student_sequence:03d}"
            student_sequence += 1
            if username in existing_usernames:
                continue

            first_name = rng.choice(FIRST_NAMES)
            last_name = rng.choice(LAST_NAMES)
            user = User(
                username=username,
                email=f"{username}@student.studynest.local",
                first_name=first_name,
                last_name=last_name,
                role="student",
                is_staff=False,
                is_active=rng.random() > 0.08,
            )
            user.set_password(password)
            user.save()

            joined_at = self.random_past_datetime(rng, min_days=15, max_days=420)
            User.objects.filter(pk=user.pk).update(date_joined=joined_at)
            user.date_joined = joined_at

            students.append(user)
            existing_usernames.add(username)
            created += 1

        return admins, students, created

    # create the fixed building records when they are missing
    def ensure_buildings(self):
        created = 0
        existing_names = set(Building.objects.values_list("name", flat=True))
        buildings = list(Building.objects.order_by("id"))

        for name, campus_area, opening_hours in BUILDING_SPECS:
            if len(buildings) >= TARGETS["buildings"]:
                break
            if name in existing_names:
                continue

            building = Building.objects.create(
                name=name,
                campus_area=campus_area,
                opening_hours=opening_hours,
            )
            buildings.append(building)
            existing_names.add(name)
            created += 1

        fallback_index = 1
        while len(buildings) < TARGETS["buildings"]:
            name = f"Study Centre {fallback_index}"
            fallback_index += 1
            if name in existing_names:
                continue

            building = Building.objects.create(
                name=name,
                campus_area="Main Campus",
                opening_hours="08:00-22:00",
            )
            buildings.append(building)
            existing_names.add(name)
            created += 1

        return buildings, created

    # create equipment records and update their statuses when needed
    def ensure_equipment(self, rng):
        created = 0
        existing_names = set(Equipment.objects.values_list("name", flat=True))
        equipment = list(Equipment.objects.order_by("id"))

        for name in EQUIPMENT_NAMES:
            if len(equipment) >= TARGETS["equipment"]:
                break
            if name in existing_names:
                continue

            item = Equipment.objects.create(
                name=name,
                status=rng.choice(EQUIPMENT_STATUSES),
            )
            equipment.append(item)
            existing_names.add(name)
            created += 1

        fallback_index = 1
        while len(equipment) < TARGETS["equipment"]:
            name = f"Shared Equipment {fallback_index}"
            fallback_index += 1
            if name in existing_names:
                continue

            item = Equipment.objects.create(name=name, status="available")
            equipment.append(item)
            existing_names.add(name)
            created += 1

        return equipment, created

    # create active rooms and attach equipment based on the room templates
    def ensure_rooms(self, rng, buildings, equipment):
        created = 0
        rooms = list(Room.objects.select_related("building").prefetch_related("equipment").order_by("id"))
        existing_names = set(room.name for room in rooms)
        building_counts = Counter(room.building_id for room in rooms)

        while len(rooms) < TARGETS["rooms"]:
            building = rng.choice(buildings)
            room_type, capacity_min, capacity_max = rng.choices(
                ROOM_TYPE_SPECS,
                weights=[16, 30, 20, 12, 10, 7, 5],
                k=1,
            )[0]
            building_counts[building.id] += 1
            sequence = building_counts[building.id]
            floor = ((sequence - 1) % 6) + 1
            room_number = floor * 100 + sequence
            name = f"{room_type} {self.building_code(building.name)}-{room_number}"

            if name in existing_names:
                continue

            room = Room.objects.create(
                name=name,
                capacity=rng.randint(capacity_min, capacity_max),
                location=f"Level {floor}, {rng.choice(WINGS)} Wing",
                is_active=rng.random() > 0.12,
                building=building,
            )

            equipment_count = self.pick_equipment_count(room_type, rng)
            room_equipment = rng.sample(equipment, k=min(equipment_count, len(equipment)))
            room.equipment.set(room_equipment)

            rooms.append(room)
            existing_names.add(name)
            created += 1

        return rooms, created

    # create a mixed set of bookings for the generated users
    def ensure_bookings(self, rng, students, admins, rooms):
        current_count = Booking.objects.count()
        missing = TARGETS["bookings"] - current_count
        if missing <= 0:
            return 0

        active_rooms = [room for room in rooms if room.is_active] or rooms
        popular_rooms = rng.sample(active_rooms, k=max(1, min(12, len(active_rooms))))
        popular_students = rng.sample(students, k=max(1, min(30, len(students))))

        occupied_slots = defaultdict(list)
        for room_id, booking_date, start_time_value, end_time_value in Booking.objects.filter(
            status__in=["pending", "approved"]
        ).values_list("room_id", "booking_date", "start_time", "end_time"):
            occupied_slots[(room_id, booking_date)].append(
                (self.time_to_minutes(start_time_value), self.time_to_minutes(end_time_value))
            )

        for value in occupied_slots.values():
            value.sort()

        created = 0
        attempts = 0

        while created < missing and attempts < missing * 30:
            attempts += 1
            status = rng.choices(
                ["approved_past", "approved_future", "pending", "rejected", "cancelled"],
                weights=[42, 14, 16, 14, 14],
                k=1,
            )[0]

            if status in {"approved_past", "approved_future", "pending"}:
                room = rng.choice(popular_rooms) if rng.random() < 0.45 else rng.choice(active_rooms)
            else:
                room = rng.choice(rooms)

            student = rng.choice(popular_students) if rng.random() < 0.35 else rng.choice(students)
            booking_date = self.pick_booking_date(status, rng)
            start_minutes, end_minutes = self.pick_time_slot(rng)

            if status in {"approved_past", "approved_future", "pending"}:
                day_slots = occupied_slots[(room.id, booking_date)]
                if self.has_conflict(day_slots, start_minutes, end_minutes):
                    continue
                day_slots.append((start_minutes, end_minutes))
                day_slots.sort()

            final_status = "approved" if status.startswith("approved") else status
            processed_by = rng.choice(admins) if final_status in {"approved", "rejected"} else None

            booking = Booking.objects.create(
                student=student,
                room=room,
                booking_date=booking_date,
                start_time=self.minutes_to_time(start_minutes),
                end_time=self.minutes_to_time(end_minutes),
                status=final_status,
                processed_by=processed_by,
            )

            created_at = self.pick_booking_created_at(
                booking_date,
                start_minutes,
                final_status,
                rng,
            )
            Booking.objects.filter(pk=booking.pk).update(created_at=created_at)
            created += 1

        return created

    # create review records for finished approved bookings
    def ensure_reviews(self, rng):
        current_count = Review.objects.count()
        missing = TARGETS["reviews"] - current_count
        if missing <= 0:
            return 0

        now = timezone.now()
        eligible_bookings = []
        queryset = (
            Booking.objects.filter(status="approved", review__isnull=True)
            .select_related("student", "room")
            .order_by("booking_date", "start_time")
        )

        for booking in queryset:
            booking_end = self.make_aware(datetime.combine(booking.booking_date, booking.end_time))
            if booking_end < now:
                eligible_bookings.append((booking, booking_end))

        rng.shuffle(eligible_bookings)
        created = 0

        for booking, booking_end in eligible_bookings[:missing]:
            rating = rng.choices([5, 4, 3, 2, 1], weights=[34, 38, 17, 7, 4], k=1)[0]
            review = Review.objects.create(
                student=booking.student,
                room=booking.room,
                booking=booking,
                rating=rating,
                comment=self.build_review_comment(rating, booking.room, rng),
            )

            created_at = booking_end + timedelta(
                hours=rng.randint(2, 72),
                days=rng.randint(0, 10),
            )
            if created_at >= now:
                created_at = now - timedelta(hours=rng.randint(1, 48))

            Review.objects.filter(pk=review.pk).update(created_at=created_at)
            created += 1

        return created

    # create support conversations and messages for the demo accounts
    def ensure_support_data(self, rng, students, admins):
        conversations = list(
            SupportConversation.objects.select_related("student", "assigned_admin").order_by("id")
        )
        messages_before = SupportMessage.objects.count()
        conversation_created = 0
        open_student_ids = set(
            SupportConversation.objects.filter(status="open").values_list("student_id", flat=True)
        )

        while len(conversations) < TARGETS["support_conversations"]:
            student = rng.choice(students)
            wants_open = rng.random() < 0.22 and student.id not in open_student_ids
            status = "open" if wants_open else "closed"
            if wants_open:
                open_student_ids.add(student.id)

            assigned_admin = rng.choice(admins) if status == "closed" or rng.random() < 0.72 else None
            created_at = self.random_past_datetime(
                rng,
                min_days=2 if status == "open" else 10,
                max_days=28 if status == "open" else 120,
            )

            conversation = SupportConversation.objects.create(
                student=student,
                assigned_admin=assigned_admin,
                status=status,
            )
            SupportConversation.objects.filter(pk=conversation.pk).update(
                created_at=created_at,
                updated_at=created_at,
                last_message_at=created_at,
            )

            conversation.created_at = created_at
            conversation.updated_at = created_at
            conversation.last_message_at = created_at
            conversations.append(conversation)
            conversation_created += 1

        target_new_messages = TARGETS["support_messages"] - messages_before
        if target_new_messages <= 0:
            return conversation_created, 0

        conversation_pool = conversations[-conversation_created:] if conversation_created else conversations
        if not conversation_pool:
            return conversation_created, 0

        message_plan = self.build_message_plan(target_new_messages, len(conversation_pool), rng)
        messages_created = 0

        for conversation, message_count in zip(conversation_pool, message_plan):
            if message_count <= 0:
                continue

            topic = rng.choice(SUPPORT_TOPICS)
            last_created_at = conversation.created_at
            assigned_admin = conversation.assigned_admin

            for index in range(message_count):
                sender_role = "student" if index % 2 == 0 else "admin"
                if sender_role == "admin":
                    if assigned_admin is None:
                        assigned_admin = rng.choice(admins)
                        SupportConversation.objects.filter(pk=conversation.pk).update(
                            assigned_admin=assigned_admin
                        )
                        conversation.assigned_admin = assigned_admin
                    sender = assigned_admin
                else:
                    sender = conversation.student

                content_pool = topic["student"] if sender_role == "student" else topic["admin"]
                content = content_pool[index % len(content_pool)]

                message = SupportMessage.objects.create(
                    conversation=conversation,
                    sender=sender,
                    content=content,
                    is_read_by_student=True,
                    is_read_by_admin=True,
                )

                last_created_at = min(
                    timezone.now() - timedelta(minutes=1),
                    last_created_at + timedelta(minutes=rng.randint(5, 360)),
                )
                is_last = index == message_count - 1
                is_read_by_student = True
                is_read_by_admin = True

                if conversation.status == "open" and is_last:
                    if sender_role == "student":
                        is_read_by_admin = False
                    else:
                        is_read_by_student = False

                SupportMessage.objects.filter(pk=message.pk).update(
                    created_at=last_created_at,
                    is_read_by_student=is_read_by_student,
                    is_read_by_admin=is_read_by_admin,
                )
                messages_created += 1

            SupportConversation.objects.filter(pk=conversation.pk).update(
                assigned_admin=assigned_admin,
                last_message_at=last_created_at,
                updated_at=last_created_at,
            )

        return conversation_created, messages_created

    # decide how many messages each support conversation should contain
    def build_message_plan(self, total_messages, conversation_count, rng):
        plan = [0] * conversation_count
        indices = list(range(conversation_count))
        rng.shuffle(indices)

        for index in indices:
            if total_messages <= 0:
                break
            if total_messages >= 2:
                plan[index] = 2
                total_messages -= 2
            else:
                plan[index] = 1
                total_messages -= 1

        while total_messages > 0:
            eligible = [index for index, count in enumerate(plan) if 0 < count < 8]
            if not eligible:
                eligible = [index for index, count in enumerate(plan) if count < 8]
            if not eligible:
                break

            index = rng.choice(eligible)
            plan[index] += 1
            total_messages -= 1

        return plan

    # build one review comment from the rating and room details
    def build_review_comment(self, rating, room, rng):
        if rating >= 4:
            detail_pool = REVIEW_DETAILS["positive"]
        elif rating == 3:
            detail_pool = REVIEW_DETAILS["mixed"]
        else:
            detail_pool = REVIEW_DETAILS["negative"]

        opener = rng.choice(REVIEW_OPENERS[rating])
        detail = rng.choice(detail_pool)
        room_note = f"{room.name} was a good fit for a group of {room.capacity}." if rating >= 4 else f"{room.name} felt less suitable than expected."
        return f"{opener} {detail} {room_note}"

    # choose how many equipment items a generated room should receive
    def pick_equipment_count(self, room_type, rng):
        if room_type == "Focus Booth":
            return rng.randint(1, 2)
        if room_type == "Quiet Pod":
            return rng.randint(2, 3)
        if room_type in {"Study Room", "Project Room"}:
            return rng.randint(2, 4)
        if room_type == "Collaboration Suite":
            return rng.randint(3, 5)
        if room_type == "Seminar Room":
            return rng.randint(4, 6)
        return rng.randint(3, 5)

    # choose a booking date that matches the requested booking status
    def pick_booking_date(self, status, rng):
        today = timezone.localdate()

        if status == "approved_past":
            return today - timedelta(days=rng.randint(1, 120))
        if status == "approved_future":
            return today + timedelta(days=rng.randint(1, 30))
        if status == "pending":
            return today + timedelta(days=rng.randint(1, 21))
        if status == "rejected":
            offset = rng.randint(-45, 35)
            return today + timedelta(days=offset)
        return today + timedelta(days=rng.randint(-30, 45))

    # pick a time slot in 30-minute steps
    def pick_time_slot(self, rng):
        start_minutes = rng.choice(range(8 * 60, 20 * 60, 30))
        duration_blocks = rng.choices([2, 3, 4, 5, 6, 8], weights=[14, 18, 22, 16, 18, 12], k=1)[0]
        end_minutes = min(start_minutes + duration_blocks * 30, 22 * 60)
        if end_minutes <= start_minutes:
            end_minutes = start_minutes + 60
        return start_minutes, end_minutes

    # create a believable created_at time for a generated booking
    def pick_booking_created_at(self, booking_date, start_minutes, status, rng):
        booking_start = self.make_aware(
            datetime.combine(booking_date, self.minutes_to_time(start_minutes))
        )
        now = timezone.now()

        if status == "pending":
            created_at = booking_start - timedelta(days=rng.randint(1, 12), hours=rng.randint(1, 12))
        elif status == "approved":
            created_at = booking_start - timedelta(days=rng.randint(1, 18), hours=rng.randint(1, 20))
        elif status == "rejected":
            created_at = booking_start - timedelta(days=rng.randint(1, 10), hours=rng.randint(1, 8))
        else:
            created_at = booking_start - timedelta(days=rng.randint(1, 14), hours=rng.randint(1, 18))

        if created_at >= now:
            created_at = now - timedelta(minutes=rng.randint(10, 1440))

        return created_at

    # check whether a new booking interval overlaps an existing one
    def has_conflict(self, intervals, start_minutes, end_minutes):
        for existing_start, existing_end in intervals:
            if existing_start < end_minutes and existing_end > start_minutes:
                return True
        return False

    # build a short code from the building name for room naming
    def building_code(self, building_name):
        letters = [word[0] for word in building_name.split() if word and word[0].isalpha()]
        code = "".join(letters[:4]).upper()
        return code or "RM"

    # convert a time object into total minutes
    def time_to_minutes(self, value):
        return value.hour * 60 + value.minute

    # convert total minutes back into a time object
    def minutes_to_time(self, minutes):
        hours = minutes // 60
        mins = minutes % 60
        return time(hour=hours, minute=mins)

    # pick a random timezone-aware datetime in the past
    def random_past_datetime(self, rng, min_days, max_days):
        now = timezone.now()
        return now - timedelta(
            days=rng.randint(min_days, max_days),
            hours=rng.randint(0, 23),
            minutes=rng.randint(0, 59),
        )

    # attach the current timezone when a datetime is naive
    def make_aware(self, value):
        if timezone.is_naive(value):
            return timezone.make_aware(value)
        return value
