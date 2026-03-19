# Study Room Booking System (StudyNest Reserve)
Study Room Booking System is a full-stack web project for campus room booking.
Students can search rooms, send booking requests, and check their booking history.
Admins can review requests and manage rooms, buildings, equipment, and users.

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

## Getting Started

### Option 1: Run The Full Docker Stack

This is the better option if you want to run the full project with frontend, backend, database, cache, and smart services.

```bash
cd docker_file/public_server
cp .env.example .env
docker compose up -d --build
```

If you also want the demo backup data, import it after the stack starts.
This will replace the current PostgreSQL data in the docker stack.

On Windows PowerShell:

```powershell
cd docker_file/public_server
Get-Content ..\..\backups\postgres\studyroom_20260317_012351.sql -Raw | docker compose exec -T -e PGPASSWORD=study123456 postgres-primary psql -h 127.0.0.1 -U studyuser -d studyroom
```

On bash:

```bash
cd docker_file/public_server
docker compose exec -T -e PGPASSWORD=study123456 postgres-primary psql -h 127.0.0.1 -U studyuser -d studyroom < ../../backups/postgres/studyroom_20260317_012351.sql
```

You can check the imported data with:

```bash
cd docker_file/public_server
docker compose exec -T -e PGPASSWORD=study123456 postgres-primary psql -h 127.0.0.1 -U studyuser -d studyroom -c "select count(*) as users_count from users_user; select count(*) as rooms_count from rooms_room; select count(*) as bookings_count from bookings_booking; select count(*) as reviews_count from reviews_review;"
```

With the current example file, the app is available at:

```text
http://127.0.0.1:8080
```


### Option 2: Run Local Development

In this mode, Docker is only used for PostgreSQL and Redis.
This option now has one extra step before you start Django and Vite.
You need to start the local support services first, because `backend/.env.development` uses:

- PostgreSQL on `127.0.0.1:5012`, `5014`, and `5015`
- Redis on `127.0.0.1:5013`

#### Step 1: Start Local Support Services

```bash
cd docker_file/local_dev
docker compose up -d --build
```

More local service notes are in `docker_file/local_dev/README.md`.

#### Step 2: Start Smart Services Locally

Go availability service (1.26.1):

```bash
cd services/go-availability-service
go run .
```

Java recommendation service (JDK21):

```bash
cd services/java-recommendation-service
./mvnw spring-boot:run
```

On Windows, you can use `mvnw.cmd` instead of `./mvnw`.

If you do not start them, the rest of the project can still run, but smart endpoints can return an unavailable error.

#### Step 3: Start Backend

```bash
cd backend
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

#### Step 4: Start Frontend

```bash
cd frontend
npm install -g pnpm
pnpm install
pnpm dev
```

The frontend development server is usually available at `http://127.0.0.1:5173`.

#### Step 5: Stop Local Support Services

```bash
cd docker_file/local_dev
docker compose down
```

If you want to reset the local postgres data and load the backup again:

```bash
cd docker_file/local_dev
docker compose down -v
docker compose up -d --build
```
