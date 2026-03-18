# Study Room Booking System
## CW5 Web Application Implementation Report

Team AA  
Course: COMPSCI5012 Internet Technology  

---

## 1. Introduction, Repository Link and Deployed Application URL

### 1.1 Project Overview

The Study Room Booking System is a web-based application that allows university students to search for study rooms and submit booking requests through an online platform. The aim of the system is to make study room reservation more efficient, organised, and transparent for both students and administrators.

Students can browse rooms and view important information such as building, location, capacity, and equipment. After choosing a suitable room, they can submit a booking request by selecting a date and a time range. The system stores these booking records and allows students to view their current bookings, booking history, and completed sessions that are eligible for review.

The system also includes an administrator interface. Administrators can review booking requests, approve or reject them, and manage core resource data such as rooms, buildings, equipment, and user accounts. This supports better control of room usage and reduces booking conflicts.

Overall, the application provides a practical and user-friendly platform for managing study room reservations while also supporting administrative oversight and system maintenance.

### 1.2 Adjustments Made to the Original Design Specification

The final implementation follows the main direction of the original design specification, but several adjustments were made during development to improve usability and better support the implemented workflow.

The most important change concerns booking processing. In the implemented system, a booking submitted by a student is first stored with the status **Pending** rather than being immediately confirmed. An administrator must then review the request and decide whether to approve or reject it. This change makes the workflow more realistic and helps prevent scheduling conflicts.

Another change concerns authentication. In the original design, separate login paths were considered for students and administrators. In the final implementation, both roles use a single login interface. After login, the system checks the role of the authenticated user and redirects the user to the appropriate dashboard automatically.

The interface design was also refined compared with the original wireframes. The final system uses a clearer navigation structure, more informative dashboards, status tags for bookings, and dedicated management pages for buildings, equipment, and user accounts. These changes improved clarity and usability while keeping the core design consistent with the original specification.

### 1.3 Code Repository Link

Public code repository:  
`https://github.com/HarryBlackCatQAQ/study_room_booking_system.git`

### 1.4 Deployed Web Application URL

Public deployed application:  
`http://ttz3305012.uk`

---

## 2. Updated Design Specification

### 2.1 System Overview

The Study Room Booking System supports two main user roles: **students** and **administrators**.

Students use the system to browse rooms, view room details, submit booking requests, track booking status, cancel bookings when necessary, and review completed bookings. The student side of the platform is designed to support the complete booking journey, from room discovery to booking history.

Administrators use the system to review booking requests and manage the system’s core data. This includes maintaining room records, building information, equipment lists, and user accounts. The administrator interface is designed to support day-to-day management tasks in a structured and efficient way.

The final system therefore combines a student-facing booking workflow with a role-protected administration interface, allowing both room users and system managers to interact with the same platform in different ways.

### 2.2 User Stories

The updated implementation is based on the following prioritised user stories from the original design specification.

**Must have**

- **M1:** As a student, I want to log in and register, so that my bookings are private and linked to my account.
- **M2:** As a student, I want to browse rooms by capacity, location, and equipment, and see real-time availability, so that I can find a suitable space.
- **M3:** As a student, I want to book a study room by selecting a date, start time, and end time, so that I can reserve a specific time slot for studying.
- **M4:** As a student, I want to view my upcoming bookings, so that I can keep track of when and where I have reserved a room. Additionally, I want to see the history of my booking.
- **M5:** As an administrator, I want to manage room details (add / edit / delete), so that the room list is always up-to-date.
- **M6:** As an administrator, I want to approve or reject bookings, so that I can control access to restricted resources.

**Should have**

- **S1:** As a student, I want to cancel a booking, so that the room becomes available if my plans change.
- **S2:** As an administrator, I want to view a dashboard of active reservations, so that I can monitor daily room usage.

**Could have**

- **C1:** As a student, I want to rate rooms, so that other students know which rooms are good.

**Won’t have**

- **W1:** As a student, I want to integrate with my university calendar, so that bookings sync automatically.

### 2.3 System Architecture Diagram

**[Insert Figure 1: Updated System Architecture Diagram]**

Figure 1 shows the high-level architecture of the implemented system. The frontend is a React single-page application built with Vite and TypeScript. It communicates with a Django backend through REST API endpoints. Django handles authentication, role-based access control, room management, booking workflows, review submission, and administrative operations.

In addition to the main Django service, the system also includes two gRPC-based supporting services. A Java service is used for room recommendation, while a Go service is used for room availability checking. These services are accessed by Django and exposed to the frontend through API endpoints. The implementation also includes caching for selected API responses and a Docker-based deployment configuration with Nginx as the public entry point.

This architecture is more advanced than a simple two-tier web application while still meeting the coursework requirement that the core backend be implemented using Python and Django.

### 2.4 Data Design

**[Insert Figure 2: Final ER Diagram]**

The implemented system uses a relational data model centred around six main entities: **User**, **Building**, **Equipment**, **Room**, **Booking**, and **Review**.

The **User** model extends Django’s authentication system and includes a `role` field to distinguish between students and administrators. A **Building** can contain multiple **Room** records, and a **Room** can be linked to multiple **Equipment** items. A **Booking** connects a student user to a room and stores the booking date, time range, status, and the administrator who processed the request. A **Review** allows a student to submit a rating and comment for a completed approved booking.

This data design supports the full workflow of authentication, room browsing, booking submission, booking approval, cancellation, and review posting while keeping the model structure consistent with the implemented system.

### 2.5 Site Structure

**[Insert Figure 3: Site Map]**

The implemented site structure keeps the original role-based layout. Public users first access the landing page and the login / register pages, and are then redirected to either the student dashboard or the administrator dashboard.

Compared with the original design, the student side now separates Browse Rooms, My Bookings, Booking History, and Profile, and also includes room detail, availability check, booking, cancellation, and review actions. On the administrator side, Room Management and Booking Requests are retained, while Building Management, Equipment Management, User Management, and Profile / Security pages are added.

This updated structure remains clear and simple, while reflecting the implemented routes more accurately than the original design version.

### 2.6 User Interface Design

**[Insert Figure 4: Wireframes / Key UI Screens]**

The early wireframes were used as the basis for the final interface design. They guided the layout of the login page, dashboard pages, room browsing interface, booking forms, and administrator management pages.

During implementation, the wireframes were refined into a more polished and consistent interface using reusable layouts, dashboard cards, status tags, form components, and responsive page sections. The final interface remains aligned with the design intention of the original specification while providing a more complete and usable user experience.

### 2.7 Changes from the Original Design Specification

Although the implemented system follows the original design closely, several changes were made during development.

#### 2.7.1 Authentication Interface Change

In the original design, separate login interfaces were considered for students and administrators. In the final implementation, this was simplified into a single login page. After successful authentication, the system checks the role of the user and redirects them to the correct dashboard automatically.

This change simplified the login process and reduced unnecessary duplication in the interface.

**[Insert Figure 5: Implemented Login Interface]**

#### 2.7.2 Student Interface Improvements

Compared with the original wireframes, the final student interface provides more guidance and more visible system feedback.

The student dashboard now presents booking-related summary information, quick access actions, and guidance for common tasks. The room browsing interface includes filters, search, and room suggestion features. The booking history page also supports the review workflow for completed sessions.

These additions make the student interface more informative and easier to use than the original draft design.

**[Insert Figure 6: Implemented Student Dashboard]**

#### 2.7.3 Administrative System Expansion

The administrative interface was expanded beyond the original wireframes. In addition to booking approval and room management, the final implementation includes dedicated pages for managing buildings, equipment, and user accounts.

These additions make the system more complete from an administrative perspective and provide better support for maintaining study room resources and user data.

**[Insert Figure 7: Implemented Administrative Interface]**

---

## 3. Implementation Highlights

### 3.1 System Architecture

The implemented system uses a multi-service web architecture. The frontend is a React single-page application built with **React**, **Vite**, **TypeScript**, **React Router**, **Axios**, and **Ant Design**, and it handles client-side routing, forms, and asynchronous UI updates.

The main backend is implemented with **Django** and **Django REST Framework**, which provide API routing, business logic, database access, role-based permissions, and JWT-based authentication. The deployed architecture also includes **Nginx** as the public entry point, a **PostgreSQL** primary database with read replicas, and a **Redis Cluster** used for caching and locking.

In addition, Django integrates with two supporting gRPC services: a **Java** service for room recommendation and a **Go** service for time-slot availability checking. This makes the final implementation broader than a simple two-tier web application while still keeping Django as the core application backend.

### 3.2 Main Components

The implemented system contains the following main components:

- **Frontend application:** student and administrator interfaces built with React.
- **Django REST API backend:** core business logic, permissions, authentication, and data access.
- **Authentication and profile module:** student registration, login, profile retrieval, and password change.
- **Room resource management module:** rooms, buildings, and equipment data management.
- **Booking lifecycle module:** booking creation, approval, rejection, cancellation, and expired-pending synchronisation.
- **Review module:** room review listing and review submission after eligible completed bookings.
- **Smart services module:** room recommendation and availability search through gRPC-integrated backend endpoints.
- **Infrastructure layer:** Nginx, PostgreSQL primary/replica deployment, and Redis-based caching support.

Each major feature is separated into reusable pages, API modules, backend apps, serializers, and service layers, which helps keep the implementation organised and maintainable.

### 3.3 Key Features

**User Authentication (M1)**  
Students can register through the public registration page, and both students and administrators can log in through JWT-based authentication. After login, the system redirects users to the correct dashboard according to role. Administrator accounts are managed through the administrative user-management workflow rather than public self-registration.

**Room Browsing (M2)**  
Students can browse rooms through search, filters, pagination, and a smart suggestion panel, then open room detail pages showing building information, capacity, equipment, ratings, and reviews.

**Room Booking (M3)**  
From the room detail page, students can check availability for a selected time range and submit a booking request. The backend validates booking rules and prevents overlapping reservations.

**Booking Tracking and History (M4)**  
`My Bookings` shows pending and upcoming requests and supports cancellation. `Booking History` stores completed, rejected, and cancelled records and allows eligible completed bookings to receive reviews.

**Room Management (M5)**  
Administrators can create, edit, and delete room records. The implemented system also extends this management flow to related building and equipment data through dedicated pages.

**Booking Approval (M6)**  
Administrators can review booking requests and approve or reject them through the booking requests page. In addition, expired pending bookings are synchronised and automatically rejected by backend lifecycle logic.

In addition to the core must-have requirements, the final system also includes profile management, password change, room reviews, building management, equipment management, user management, room recommendation, and availability checking.

### 3.4 Front-end Interactivity

The application clearly demonstrates client-side interactivity beyond static page rendering.

The React frontend supports dynamic room filtering and pagination, role-based route protection, validation on authentication, booking, and management forms, modal-based booking and review flows, and live feedback after asynchronous actions such as login, booking submission, approval, or review creation.

The recommendation panel and availability checker both send asynchronous requests and update the interface without requiring a full page reload. These behaviours provide clear evidence that the application meets the coursework requirement for frontend interactivity.

### 3.5 Look and Feel

The interface was designed to be polished, consistent, and responsive.

The project uses Ant Design components together with custom CSS for dashboards, cards, tables, navigation, status displays, and forms. Shared student and administrator layout components help maintain a consistent visual language across the system.

Responsive CSS rules and flexible layouts allow key pages such as the authentication screens, dashboards, room pages, and record tables to adapt to smaller screens. As a result, the final application provides a more professional and coherent user experience than the original wireframes.

### 3.6 Code Quality and Organisation

The codebase is organised to support separation of concerns and reusability.

On the frontend, routes, page components, API clients, layouts, reusable components, styles, and types are separated into dedicated modules. API configuration uses a configurable base URL and a token-refresh interceptor rather than hard-coded requests inside UI components.

On the backend, functionality is divided into dedicated Django apps including `users`, `rooms`, `bookings`, `reviews`, and `smart_services`, with serializers, services, permissions, database routing, and cache configuration kept in separate modules. Route-level lazy loading was also introduced so that large page modules are loaded only when needed. This structure supports maintainability, reuse, and easier testing.

---

## 4. Testing

Testing combined automated API tests with manual browser-based verification.

The automated suite was written using Django REST Framework testing tools and covers authentication, profile retrieval, password change, room list and detail retrieval, admin room permissions, booking creation, booking conflict prevention, cancellation, booking approval and rejection, automatic rejection of expired pending bookings, review submission rules, and administrative user management.

The automated test run used in this report was executed on **17 March 2026** with the following command:

```bash
./.venv/bin/python backend/manage.py test bookings reviews users rooms smart_services
```

The recorded result was:

```text
Ran 42 tests in 90.226s
OK
```

The `smart_services` app was included in the command so the full backend suite ran together, but the recommendation and availability flows were mainly verified through manual end-to-end testing.

Manual testing checked the main user journeys in the browser, including student registration and login, room browsing, room detail and availability checking, booking submission, booking cancellation, administrator approval or rejection, booking history viewing, and review submission after an eligible completed booking.

Together, these automated and manual checks provide evidence that the implemented system behaves correctly for the main coursework requirements.

**[Insert Figure 8: Screenshot of automated test output]**

---

## 5. Accessibility Report

The accessibility plan from the design phase was applied to the final system through several concrete improvements on key pages such as login, registration, booking, profile, and management forms.

### 5.1 Keyboard Accessibility

Important workflows can be completed by keyboard. Users can move through links, buttons, inputs, selects, and date pickers without relying on a mouse, and tasks such as login, registration, booking submission, and management-form interaction remain usable through standard keyboard navigation.

**[Insert Figure 9: Screenshot showing keyboard navigation or focused element]**

### 5.2 Visible Focus Indicators

Visible focus styling was added to improve keyboard usability. Buttons, input fields, select controls, and picker components show a clear focus outline, making it easier for users to see which element is currently active.

**[Insert Figure 10: Screenshot showing visible focus outline]**

### 5.3 Clear Labels and Input Guidance

Forms across the system use clear labels and supporting guidance. Login, registration, booking, password-change, and management forms all use labelled fields, and several inputs also provide placeholders or validation messages to help users understand what information is required.

**[Insert Figure 11: Screenshot showing labelled login or booking form]**

### 5.4 Summary

These improvements show that the accessibility plan was implemented in the final system rather than remaining only at the design stage. The changes focus on visible, practical usability improvements that can be demonstrated through screenshots from the implemented interface.

---

## 6. Sustainability Report

The sustainability-related performance evaluation was carried out using **Google Lighthouse 13.0.3**. To keep the measurement environment consistent, the tests were run on **18 March 2026** against a local production preview built from the submitted frontend code.

### 6.1 Tool and Pages Tested

The following two pages were tested:

- Homepage: `http://127.0.0.1:4173/`
- Login page: `http://127.0.0.1:4173/login`

These pages were selected because they represent the public entry points of the application and satisfy the coursework requirement to measure at least two user-facing pages.

### 6.2 Baseline Measurement

The baseline Lighthouse results before the optimisation were:

| Page | Performance | Accessibility | Best Practices | SEO |
| --- | ---: | ---: | ---: | ---: |
| Homepage | 70 | 98 | 100 | 83 |
| Login page | 78 | 94 | 100 | 82 |

The baseline results showed that the main issue was frontend payload size. On the homepage, Lighthouse reported **First Contentful Paint 4.1 s**, **Largest Contentful Paint 5.1 s**, **Total Blocking Time 130 ms**, and about **338 KiB** of unused JavaScript. On the login page, it reported **First Contentful Paint 3.5 s**, **Largest Contentful Paint 4.1 s**, **Total Blocking Time 130 ms**, about **319 KiB** of unused JavaScript, and about **15 KiB** of unused CSS.

### 6.3 Changes Implemented

One real optimisation was implemented and measured for this report: route-level code splitting in the React router using `React.lazy` and `Suspense`, so large page modules are loaded only when they are needed.

This reduced the amount of JavaScript processed during the initial page load. In the production build before the optimisation, Vite generated one main JavaScript bundle of **1,474.14 kB** before gzip (**452.99 kB** gzip). After the optimisation, the largest shared JavaScript chunk dropped to **669.62 kB** before gzip (**222.07 kB** gzip), with additional route-specific chunks loaded separately. The project also already uses Redis-backed caching for frequently requested room and review endpoints, but the measured improvement discussed here came from the new frontend loading strategy.

### 6.4 After Measurement and Reflection

After implementing route-level code splitting, Lighthouse was run again on the same two pages:

| Page | Performance Before | Performance After | Accessibility Before | Accessibility After | Best Practices Before | Best Practices After |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Homepage | 70 | 84 | 98 | 98 | 100 | 100 |
| Login page | 78 | 83 | 94 | 94 | 100 | 100 |

The after-measurement also showed improved loading metrics. Homepage **First Contentful Paint** improved from **4.1 s** to **2.8 s**, **Largest Contentful Paint** from **5.1 s** to **3.8 s**, **Total Blocking Time** from **130 ms** to **30 ms**, and unused JavaScript fell from about **338 KiB** to about **116 KiB**. On the login page, **First Contentful Paint** improved from **3.5 s** to **2.8 s**, **Largest Contentful Paint** from **4.1 s** to **3.9 s**, **Total Blocking Time** from **130 ms** to **60 ms**, and unused JavaScript fell from about **319 KiB** to about **106 KiB**.

The main improvement came from reducing the amount of frontend code that had to be downloaded and processed during the initial page load. Accessibility and best-practice scores remained stable because the optimisation targeted delivery and loading behaviour rather than changing form semantics or navigation patterns.

**[Insert Figure 12: Lighthouse baseline screenshot]**  
**[Insert Figure 13: Lighthouse after-optimisation screenshot]**

---

## 7. Appendix: Team Contributions and AI Use Statement

### 7.1 Team Contributions

- **Haorong Huang** – Database design and system architecture (34%)
- **Haozhe Zhang** – User stories and system overview (33%)
- **Enyang Tu** – Sitemap, wireframes, and accessibility design (33%)

### 7.2 AI Use Statement

Declaration on the use of Generative AI:

- We declare that we have used GenAI for copy-editing and improving the clarity of language in the report.
- We declare that we have used GenAI for limited debugging support, code-quality suggestions, testing ideas, accessibility guidance, sustainability analysis, and small refactoring suggestions.

Tool(s) used: ChatGPT  
Parts affected: report drafting and editing, report structure, debugging guidance, testing ideas, accessibility guidance, sustainability interpretation, and limited code-quality suggestions.  
How correctness was ensured: we checked the final report against the coursework brief, verified the report content against our own codebase, and validated implementation details through builds, tests, and manual review before submission.
