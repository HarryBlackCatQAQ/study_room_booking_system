from google.protobuf.internal import containers as _containers
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from collections.abc import Iterable as _Iterable, Mapping as _Mapping
from typing import ClassVar as _ClassVar, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class RoomSnapshot(_message.Message):
    __slots__ = ("room_id", "room_name", "capacity", "building_id", "building_name", "equipment_names", "is_active")
    ROOM_ID_FIELD_NUMBER: _ClassVar[int]
    ROOM_NAME_FIELD_NUMBER: _ClassVar[int]
    CAPACITY_FIELD_NUMBER: _ClassVar[int]
    BUILDING_ID_FIELD_NUMBER: _ClassVar[int]
    BUILDING_NAME_FIELD_NUMBER: _ClassVar[int]
    EQUIPMENT_NAMES_FIELD_NUMBER: _ClassVar[int]
    IS_ACTIVE_FIELD_NUMBER: _ClassVar[int]
    room_id: int
    room_name: str
    capacity: int
    building_id: int
    building_name: str
    equipment_names: _containers.RepeatedScalarFieldContainer[str]
    is_active: bool
    def __init__(self, room_id: _Optional[int] = ..., room_name: _Optional[str] = ..., capacity: _Optional[int] = ..., building_id: _Optional[int] = ..., building_name: _Optional[str] = ..., equipment_names: _Optional[_Iterable[str]] = ..., is_active: bool = ...) -> None: ...

class BookingSnapshot(_message.Message):
    __slots__ = ("room_id", "booking_date", "start_time", "end_time", "status")
    ROOM_ID_FIELD_NUMBER: _ClassVar[int]
    BOOKING_DATE_FIELD_NUMBER: _ClassVar[int]
    START_TIME_FIELD_NUMBER: _ClassVar[int]
    END_TIME_FIELD_NUMBER: _ClassVar[int]
    STATUS_FIELD_NUMBER: _ClassVar[int]
    room_id: int
    booking_date: str
    start_time: str
    end_time: str
    status: str
    def __init__(self, room_id: _Optional[int] = ..., booking_date: _Optional[str] = ..., start_time: _Optional[str] = ..., end_time: _Optional[str] = ..., status: _Optional[str] = ...) -> None: ...

class ReviewStat(_message.Message):
    __slots__ = ("room_id", "average_rating", "review_count")
    ROOM_ID_FIELD_NUMBER: _ClassVar[int]
    AVERAGE_RATING_FIELD_NUMBER: _ClassVar[int]
    REVIEW_COUNT_FIELD_NUMBER: _ClassVar[int]
    room_id: int
    average_rating: float
    review_count: int
    def __init__(self, room_id: _Optional[int] = ..., average_rating: _Optional[float] = ..., review_count: _Optional[int] = ...) -> None: ...

class RecommendationRequest(_message.Message):
    __slots__ = ("booking_date", "start_time", "end_time", "min_capacity", "required_equipment", "preferred_building_id", "rooms", "bookings", "review_stats")
    BOOKING_DATE_FIELD_NUMBER: _ClassVar[int]
    START_TIME_FIELD_NUMBER: _ClassVar[int]
    END_TIME_FIELD_NUMBER: _ClassVar[int]
    MIN_CAPACITY_FIELD_NUMBER: _ClassVar[int]
    REQUIRED_EQUIPMENT_FIELD_NUMBER: _ClassVar[int]
    PREFERRED_BUILDING_ID_FIELD_NUMBER: _ClassVar[int]
    ROOMS_FIELD_NUMBER: _ClassVar[int]
    BOOKINGS_FIELD_NUMBER: _ClassVar[int]
    REVIEW_STATS_FIELD_NUMBER: _ClassVar[int]
    booking_date: str
    start_time: str
    end_time: str
    min_capacity: int
    required_equipment: _containers.RepeatedScalarFieldContainer[str]
    preferred_building_id: int
    rooms: _containers.RepeatedCompositeFieldContainer[RoomSnapshot]
    bookings: _containers.RepeatedCompositeFieldContainer[BookingSnapshot]
    review_stats: _containers.RepeatedCompositeFieldContainer[ReviewStat]
    def __init__(self, booking_date: _Optional[str] = ..., start_time: _Optional[str] = ..., end_time: _Optional[str] = ..., min_capacity: _Optional[int] = ..., required_equipment: _Optional[_Iterable[str]] = ..., preferred_building_id: _Optional[int] = ..., rooms: _Optional[_Iterable[_Union[RoomSnapshot, _Mapping]]] = ..., bookings: _Optional[_Iterable[_Union[BookingSnapshot, _Mapping]]] = ..., review_stats: _Optional[_Iterable[_Union[ReviewStat, _Mapping]]] = ...) -> None: ...

class RecommendedRoom(_message.Message):
    __slots__ = ("room_id", "room_name", "building_name", "score", "reason")
    ROOM_ID_FIELD_NUMBER: _ClassVar[int]
    ROOM_NAME_FIELD_NUMBER: _ClassVar[int]
    BUILDING_NAME_FIELD_NUMBER: _ClassVar[int]
    SCORE_FIELD_NUMBER: _ClassVar[int]
    REASON_FIELD_NUMBER: _ClassVar[int]
    room_id: int
    room_name: str
    building_name: str
    score: float
    reason: str
    def __init__(self, room_id: _Optional[int] = ..., room_name: _Optional[str] = ..., building_name: _Optional[str] = ..., score: _Optional[float] = ..., reason: _Optional[str] = ...) -> None: ...

class RecommendationResponse(_message.Message):
    __slots__ = ("rooms",)
    ROOMS_FIELD_NUMBER: _ClassVar[int]
    rooms: _containers.RepeatedCompositeFieldContainer[RecommendedRoom]
    def __init__(self, rooms: _Optional[_Iterable[_Union[RecommendedRoom, _Mapping]]] = ...) -> None: ...

class AvailabilityRequest(_message.Message):
    __slots__ = ("booking_date", "search_start_time", "search_end_time", "duration_minutes", "min_capacity", "building_id", "required_equipment", "rooms", "bookings")
    BOOKING_DATE_FIELD_NUMBER: _ClassVar[int]
    SEARCH_START_TIME_FIELD_NUMBER: _ClassVar[int]
    SEARCH_END_TIME_FIELD_NUMBER: _ClassVar[int]
    DURATION_MINUTES_FIELD_NUMBER: _ClassVar[int]
    MIN_CAPACITY_FIELD_NUMBER: _ClassVar[int]
    BUILDING_ID_FIELD_NUMBER: _ClassVar[int]
    REQUIRED_EQUIPMENT_FIELD_NUMBER: _ClassVar[int]
    ROOMS_FIELD_NUMBER: _ClassVar[int]
    BOOKINGS_FIELD_NUMBER: _ClassVar[int]
    booking_date: str
    search_start_time: str
    search_end_time: str
    duration_minutes: int
    min_capacity: int
    building_id: int
    required_equipment: _containers.RepeatedScalarFieldContainer[str]
    rooms: _containers.RepeatedCompositeFieldContainer[RoomSnapshot]
    bookings: _containers.RepeatedCompositeFieldContainer[BookingSnapshot]
    def __init__(self, booking_date: _Optional[str] = ..., search_start_time: _Optional[str] = ..., search_end_time: _Optional[str] = ..., duration_minutes: _Optional[int] = ..., min_capacity: _Optional[int] = ..., building_id: _Optional[int] = ..., required_equipment: _Optional[_Iterable[str]] = ..., rooms: _Optional[_Iterable[_Union[RoomSnapshot, _Mapping]]] = ..., bookings: _Optional[_Iterable[_Union[BookingSnapshot, _Mapping]]] = ...) -> None: ...

class AvailableSlot(_message.Message):
    __slots__ = ("room_id", "room_name", "building_name", "start_time", "end_time")
    ROOM_ID_FIELD_NUMBER: _ClassVar[int]
    ROOM_NAME_FIELD_NUMBER: _ClassVar[int]
    BUILDING_NAME_FIELD_NUMBER: _ClassVar[int]
    START_TIME_FIELD_NUMBER: _ClassVar[int]
    END_TIME_FIELD_NUMBER: _ClassVar[int]
    room_id: int
    room_name: str
    building_name: str
    start_time: str
    end_time: str
    def __init__(self, room_id: _Optional[int] = ..., room_name: _Optional[str] = ..., building_name: _Optional[str] = ..., start_time: _Optional[str] = ..., end_time: _Optional[str] = ...) -> None: ...

class AvailabilityResponse(_message.Message):
    __slots__ = ("slots",)
    SLOTS_FIELD_NUMBER: _ClassVar[int]
    slots: _containers.RepeatedCompositeFieldContainer[AvailableSlot]
    def __init__(self, slots: _Optional[_Iterable[_Union[AvailableSlot, _Mapping]]] = ...) -> None: ...

class PendingBookingSnapshot(_message.Message):
    __slots__ = ("booking_id", "booking_date", "start_time", "status")
    BOOKING_ID_FIELD_NUMBER: _ClassVar[int]
    BOOKING_DATE_FIELD_NUMBER: _ClassVar[int]
    START_TIME_FIELD_NUMBER: _ClassVar[int]
    STATUS_FIELD_NUMBER: _ClassVar[int]
    booking_id: int
    booking_date: str
    start_time: str
    status: str
    def __init__(self, booking_id: _Optional[int] = ..., booking_date: _Optional[str] = ..., start_time: _Optional[str] = ..., status: _Optional[str] = ...) -> None: ...

class ExpiredPendingBookingsRequest(_message.Message):
    __slots__ = ("current_date", "current_time", "bookings")
    CURRENT_DATE_FIELD_NUMBER: _ClassVar[int]
    CURRENT_TIME_FIELD_NUMBER: _ClassVar[int]
    BOOKINGS_FIELD_NUMBER: _ClassVar[int]
    current_date: str
    current_time: str
    bookings: _containers.RepeatedCompositeFieldContainer[PendingBookingSnapshot]
    def __init__(self, current_date: _Optional[str] = ..., current_time: _Optional[str] = ..., bookings: _Optional[_Iterable[_Union[PendingBookingSnapshot, _Mapping]]] = ...) -> None: ...

class ExpiredPendingBookingsResponse(_message.Message):
    __slots__ = ("expired_booking_ids",)
    EXPIRED_BOOKING_IDS_FIELD_NUMBER: _ClassVar[int]
    expired_booking_ids: _containers.RepeatedScalarFieldContainer[int]
    def __init__(self, expired_booking_ids: _Optional[_Iterable[int]] = ...) -> None: ...
