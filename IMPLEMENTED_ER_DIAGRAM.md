# Implemented ER Diagram

This file contains the ER diagram that matches the **actual implemented Django models**.

## Mermaid ER Diagram

```mermaid
erDiagram
    USER {
        bigint id PK
        string username
        string email
        string password
        string role
    }

    BUILDING {
        bigint id PK
        string name
        string campus_area
        string opening_hours
    }

    EQUIPMENT {
        bigint id PK
        string name
        string status
    }

    ROOM {
        bigint id PK
        string name
        int capacity
        string location
        boolean is_active
        bigint building_id FK
    }

    BOOKING {
        bigint id PK
        bigint student_id FK
        bigint room_id FK
        bigint processed_by_id FK
        date booking_date
        time start_time
        time end_time
        string status
        datetime created_at
    }

    REVIEW {
        bigint id PK
        bigint student_id FK
        bigint room_id FK
        bigint booking_id FK
        int rating
        string comment
        datetime created_at
    }

    USER ||--o{ BOOKING : makes
    USER o|--o{ BOOKING : processes
    ROOM ||--o{ BOOKING : is_reserved_in
    BUILDING ||--o{ ROOM : contains
    ROOM }o--o{ EQUIPMENT : has
    USER ||--o{ REVIEW : writes
    ROOM ||--o{ REVIEW : receives
    BOOKING ||--o| REVIEW : may_have
```

## Suggested Caption

**Figure X. Entity Relationship Diagram of the implemented Study Room Booking System.**
