# study_room_booking_system

## Project Structure

```text
study_room_booking_system/
├── backend/                         # Django backend, APIs, data models, and business logic
│   ├── bookings/                    # Booking workflows, services, and management commands
│   ├── config/                      # Global settings, routes, middleware, cache, and database config
│   ├── reviews/                     # Review and rating module
│   ├── rooms/                       # Room management, permissions, serializers, and APIs
│   ├── smart_services/              # Smart service integration endpoints and related models
│   └── users/                       # User accounts, serializers, and user APIs
├── frontend/                        # Vite + React frontend application
│   ├── public/                      # Static public assets
│   └── src/                         # Application source code, pages, components, APIs, and styles
├── services/                        # Independent microservices used by the platform
│   ├── go-availability-service/     # Go gRPC service for room availability logic
│   └── java-recommendation-service/ # Java service for recommendation features
├── proto/                           # Shared gRPC protocol definitions
├── docker_file/                     # Dockerfiles, deployment configs, nginx, redis, and startup scripts
├── backups/                         # Database backup files
├── README.md                        # Project overview
└── DEPLOY_PUBLIC.md                 # Public deployment notes
```

## Folder Notes

- `backend/`: Contains the main server-side application built with Django. It handles APIs, business rules, data storage, and admin logic.
- `backend/bookings/`: Manages room reservation flows, booking status updates, and scheduled maintenance commands.
- `backend/config/`: Stores the shared backend configuration, including URL routing, middleware, database routing, and cache setup.
- `backend/reviews/`: Provides review-related models, serializers, views, and routes.
- `backend/rooms/`: Handles room information, availability-related APIs, and room access rules.
- `backend/smart_services/`: Connects the backend with smart or recommendation-related service features.
- `backend/users/`: Manages user models, account serialization, and user-facing endpoints.
- `frontend/`: Contains the client-side web application for students and administrators.
- `frontend/public/`: Stores static assets that are served directly.
- `frontend/src/`: Holds the main frontend code, including pages, reusable components, API clients, routing, and styles.
- `services/`: Keeps standalone backend services that support specific platform features.
- `services/go-availability-service/`: Implements availability checking logic with Go and gRPC.
- `services/java-recommendation-service/`: Provides recommendation-related processing with Java.
- `proto/`: Defines shared protocol buffer files for communication between services.
- `docker_file/`: Includes container build files and deployment resources for running the system in Docker-based environments.
- `backups/`: Stores exported database snapshots for recovery or migration use.
