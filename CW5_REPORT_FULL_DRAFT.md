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

The site structure is organised around role-based navigation.

On the student side, users can access the landing page, login and registration pages, student dashboard, room browsing page, room detail page, my bookings page, booking history page, and profile page.

On the administrator side, authenticated admin users can access the admin dashboard, booking request management page, room management page, building management page, equipment management page, user management page, and profile page.

This structure keeps the student journey simple while also separating administrative tasks into focused management pages.

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

The final system uses a separated frontend and backend architecture.

The frontend is implemented as a React single-page application using **React**, **Vite**, **TypeScript**, **React Router**, **Axios**, and **Ant Design**. This frontend is responsible for rendering the user interface, handling client-side routing, validating user input, and performing asynchronous API requests.

The backend is implemented using **Django** and **Django REST Framework**. It provides the application’s main business logic, API endpoints, database interaction, role-based permissions, and authentication features. Authentication is handled using JWT tokens so that protected API endpoints can be accessed securely from the frontend.

Beyond the core Django backend, the project also includes two supporting services. A **Java gRPC service** provides room recommendation functionality, and a **Go gRPC service** provides availability searching for requested time ranges. These services are called by Django and exposed to the frontend through API endpoints.

### 3.2 Main Components

The implemented system contains the following main components:

- **Frontend application:** student and administrator interfaces built with React.
- **Authentication module:** registration, login, profile, and password change endpoints.
- **Room management module:** room listing, room detail, room creation, update, and deletion.
- **Booking module:** booking creation, booking listing, cancellation, approval, and rejection.
- **Review module:** room review listing and review submission after completed approved bookings.
- **Administrative management module:** building, equipment, and user account management.
- **Smart services module:** room recommendation and availability search via gRPC-integrated backend endpoints.

Each major feature is separated into reusable pages, API modules, backend apps, serializers, and service layers, which helps keep the implementation organised and maintainable.

### 3.3 Key Features

**User Authentication (M1)**  
User authentication is implemented using Django-based backend logic and JWT authentication for API access. Students and administrators can register and log in, and the system redirects authenticated users to the correct dashboard according to their role.

**Room Browsing (M2)**  
Students can browse rooms on the room listing page and view room details such as building, location, capacity, and equipment. The interface also supports filtering and searching to help users find a suitable room more quickly.

**Room Booking (M3)**  
Students can submit a booking request by choosing a room, date, start time, and end time. The backend validates the request and prevents overlapping bookings.

**Booking Tracking and History (M4)**  
Students can view their current booking requests and booking history. The history page also allows completed approved bookings to be reviewed.

**Room Management (M5)**  
Administrators can create, update, and delete room records through dedicated management pages.

**Booking Approval (M6)**  
Administrators can review booking requests and approve or reject them. Approved and rejected requests are recorded with status updates.

In addition to the core must-have requirements, the final system also includes booking cancellation, room reviews, building management, equipment management, user management, room recommendation, and availability checking.

### 3.4 Front-end Interactivity

The application clearly demonstrates client-side interactivity beyond static page rendering.

The React frontend provides dynamic room filtering and pagination, form validation, asynchronous API requests, role-based route protection, and live interface updates after user actions such as login, booking creation, or request approval. The booking forms, login forms, and management forms all validate required input before submission.

The system also includes two interactive smart features. The room recommendation interface submits form data asynchronously and displays suggested rooms based on the selected criteria. The availability checking interface allows users to query a time range and immediately view available rooms without requiring a full page reload.

These behaviours provide clear evidence that the application meets the coursework requirement for frontend interactivity.

### 3.5 Look and Feel

The interface was designed to be polished, consistent, and responsive.

The project uses Ant Design components together with custom CSS for layouts, forms, cards, tables, navigation, status displays, and page sections. Shared layout components are used for both student and administrator views, helping the system maintain a consistent visual language.

The colour palette, spacing, typography, and dashboard layout were designed to make the interface more refined than the original wireframes. Responsive CSS is also used so that major pages, particularly authentication and dashboard layouts, adapt to smaller screens. As a result, the final application provides a more professional and coherent user experience.

### 3.6 Code Quality and Organisation

The codebase is organised to support separation of concerns and reusability.

On the frontend, routing, API access, reusable components, page components, styles, and utility functions are separated into different modules. On the backend, functionality is divided into dedicated Django apps including users, rooms, bookings, reviews, and smart services.

Reusable serializers, API client modules, and shared layout components reduce duplication and make the code easier to maintain. API configuration is also kept separate from page code so that frontend requests are not hard-coded directly inside UI components. This structure helps the implementation satisfy the coursework expectations for readable and well-organised code.

---

## 4. Testing

Testing was carried out using a combination of automated API tests and manual browser-based testing.

The automated tests were implemented using Django REST Framework’s testing tools. These tests focus on important business rules and API behaviour across the authentication, booking, room, and review modules.

The automated test suite covers the following areas:

- user registration and login
- invalid login handling
- profile retrieval and password change
- room list and room detail retrieval
- admin room creation permissions
- booking creation
- booking conflict prevention
- booking cancellation
- admin booking approval and rejection
- auto-rejection of expired pending bookings
- review creation rules
- restrictions on reviewing incomplete or already reviewed bookings
- administrative user management behaviour

The automated tests were run on **17 March 2026** using the following command:

```bash
./.venv/bin/python backend/manage.py test bookings reviews users rooms smart_services
```

The result was:

```text
Ran 42 tests in 90.226s
OK
```

In addition to the automated tests, manual testing was used to verify the complete user journey in the browser. This included logging in, browsing rooms, submitting a booking request, approving or rejecting a booking as an administrator, viewing booking history, and submitting a room review after a completed booking.

Together, these automated and manual checks provide evidence that the implemented system behaves correctly for the main coursework requirements.

**[Insert Figure 8: Screenshot of automated test output]**

---

## 5. Accessibility Report

The accessibility plan created during the design phase was applied to the final system through several practical interface improvements. The improvements were mainly implemented on the login page, booking-related forms, and other important user input flows.

### 5.1 Keyboard Accessibility

The system supports keyboard-based interaction for important user tasks. Users can move through form fields, buttons, and links using the keyboard, and actions such as login and booking submission can be completed without relying on a mouse.

This improves usability for keyboard-only users and supports more accessible interaction across the interface.

**[Insert Figure 9: Screenshot showing keyboard navigation or focused element]**

### 5.2 Visible Focus Indicators

Visible focus styling was added so that users can clearly see which interactive element is currently selected when navigating by keyboard. Buttons, input fields, select components, and date/time pickers all display a clear focus outline.

This change directly supports the accessibility plan by making keyboard navigation easier to follow.

**[Insert Figure 10: Screenshot showing visible focus outline]**

### 5.3 Clear Labels and Input Guidance

Forms across the system use clear labels and supporting guidance. For example, the login page includes labelled fields for **Username** and **Password**, and the booking form includes labelled fields for **Date**, **Start Time**, and **End Time**. Some fields also include placeholders or validation messages to help users understand what information is expected.

This reduces user error and improves accessibility for users who need clearer form semantics.

**[Insert Figure 11: Screenshot showing labelled login or booking form]**

### 5.4 Summary

These improvements show that the accessibility plan was applied in the implemented system rather than remaining only at the design stage. The changes focus on practical usability improvements that are visible in the final user interface and supported by evidence from key pages.

---

## 6. Sustainability Report

The sustainability-related performance of the application was evaluated using **Google Lighthouse**. The evaluation focused on user-facing pages because the coursework brief requires performance evidence for at least two pages, including the homepage and one core feature page.

### 6.1 Tool and Pages Tested

The following pages were tested on **17 March 2026**:

- Homepage: `http://ttz3305012.uk/`
- Login page: `http://ttz3305012.uk/login`

These pages were selected because they are public entry points to the application and represent important user-facing parts of the system.

### 6.2 Baseline Measurement

The baseline Lighthouse results were:

| Page | Performance | Accessibility | Best Practices | SEO |
| --- | ---: | ---: | ---: | ---: |
| Homepage | 46 | 98 | 78 | 83 |
| Login page | 40 | 94 | 78 | 82 |

The baseline results showed that accessibility was already relatively strong, but performance was weaker. The main issue identified by Lighthouse was the size of the frontend JavaScript bundle. For example, Lighthouse estimated unused JavaScript savings of approximately **1,098 KiB** on the homepage and **1,039 KiB** on the login page.

### 6.3 Changes Implemented

To improve sustainability-related performance, the frontend should be optimised to reduce the amount of JavaScript loaded during the initial page load. Suitable implemented changes include:

- introducing route-level code splitting for page components
- reducing unnecessary JavaScript in the initial bundle
- reducing unused CSS where possible
- keeping frequently requested room and building endpoints cached

**Important:** this subsection must describe only the changes that were actually implemented in the final submitted version. If additional optimisation work is completed before submission, this paragraph should be updated to reflect the exact changes made.

### 6.4 After Measurement and Reflection

After implementing the performance improvements, Lighthouse should be run again on the same two pages and the updated results should be reported below.

| Page | Performance Before | Performance After | Accessibility Before | Accessibility After | Best Practices Before | Best Practices After |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Homepage | 46 | **[Fill in]** | 98 | **[Fill in]** | 78 | **[Fill in]** |
| Login page | 40 | **[Fill in]** | 94 | **[Fill in]** | 78 | **[Fill in]** |

Suggested reflection text after you fill in the real values:

The main improvement came from reducing the amount of frontend code that needed to be processed during the initial page load. After optimisation, the tested pages loaded more efficiently, which improved the performance score and reduced unnecessary resource usage. Accessibility remained strong because the optimisation work focused mainly on bundle size and page delivery rather than changing form semantics or navigation behaviour.

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
- We declare that we have used GenAI for limited debugging support, code-quality suggestions, test ideas, and guidance on accessibility and sustainability reporting.

Tool(s) used: ChatGPT  
Parts affected: report drafting/editing, report structure, debugging guidance, testing ideas, accessibility guidance, and sustainability interpretation.  
How correctness was ensured: we checked the final report against the coursework brief, verified the report content against our own codebase, and validated implementation details through builds, tests, and manual review before submission.

---

## Final Notes Before Exporting to PDF

- Replace all figure placeholders with real screenshots or diagrams.
- Keep the section page limits in mind when transferring this draft into Word.
- Do not claim any sustainability improvement as implemented unless it was actually implemented and re-measured.
- If the ER diagram still shows entities not present in the final code, update it before submission.
