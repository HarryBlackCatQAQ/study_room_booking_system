# CW5 Report Revision Guide

## Overall verdict

The current draft has the correct main section structure, but it is not fully compliant yet.

The most important fixes before submission are:

- Add the public repository URL and the deployed application URL.
- Replace the inaccurate implementation description. The project is not a Django + Bootstrap monolith; it uses a React/Vite frontend, a Django API backend, and two gRPC services.
- Correct the data model description. The implemented system has a custom `User` model with a `role` field, not separate `Student`, `Role`, and `Permission` models.
- Remove unsupported claims such as the “support desk interface”.
- Add real testing evidence and a working test command.
- Rewrite the accessibility section so it clearly states 3 implemented improvements and shows evidence.
- Rewrite the sustainability section so it contains a real baseline, real implemented changes, and a real after-measurement.
- Add an AI Use Statement in the appendix.
- Keep the final PDF within the section page limits from the brief.

## Verified project facts

- Public repository URL: `https://github.com/HarryBlackCatQAQ/study_room_booking_system.git`
- Public deployed URL verified on 17 March 2026: `http://ttz3305012.uk`
- Frontend stack: React 19, Vite, TypeScript, Ant Design, React Router, Axios
- Backend stack: Django, Django REST Framework, JWT authentication
- Extra services: Java gRPC room recommendation service, Go gRPC availability service
- Caching: Django `cache_page` with Redis-compatible cache configuration
- Automated testing verified on 17 March 2026:
  `./.venv/bin/python backend/manage.py test bookings reviews users rooms smart_services`
- Test result verified on 17 March 2026:
  `Ran 42 tests in 90.226s` and `OK`
- Frontend production build verified on 17 March 2026:
  `pnpm build` succeeded
- Frontend bundle warning from the build:
  `dist/assets/index-xhBk5Ro-.js` is about `1,474.14 kB` before gzip and `452.99 kB` after gzip

## Section-by-section fixes

### 1.3 Code Repository Link

Replace the placeholder with:

`Public code repository: https://github.com/HarryBlackCatQAQ/study_room_booking_system.git`

### 1.4 Deployed Web Application URL

Replace the placeholder with:

`Public deployed application: http://ttz3305012.uk`

Do not write `https://ttz3305012.uk` unless you have actually enabled HTTPS. On 17 March 2026, HTTP was reachable and HTTPS was not.

### 2.3 System Architecture Diagram paragraph

Use this replacement paragraph:

The final implementation uses a multi-service web architecture. The user interface is a React single-page application built with Vite and TypeScript. It communicates with a Django REST API that handles authentication, booking logic, room management, review submission, and administrative workflows. In addition to the main Django service, the system includes a Java gRPC service for room recommendation and a Go gRPC service for availability search. Room, building, equipment, and review endpoints are cached to improve response efficiency, and the deployment configuration uses Docker and Nginx as the public entry point. This architecture is more advanced than a simple two-tier web app while still keeping Django as the core application backend required by the coursework.

### 2.4 Data Design note

If your ER diagram still shows separate `Role` or `Permission` entities, update the diagram or explicitly explain that the final implementation simplifies this into a single custom `User` model with a `role` field (`student` or `admin`).

### 2.7.3 Administrative System Expansion

Replace the current paragraph with:

The administrative interface was expanded beyond the original wireframes. In addition to booking approval and room management, administrators can manage buildings, equipment, and user accounts through dedicated pages. This makes the final system more complete than the original design and better supports day-to-day administration of rooms and booking data. These additions extend the original design while keeping the main booking workflow unchanged.

Do not mention a support desk interface unless you actually implemented one.

### 3.1 System Architecture

Replace the current subsection with:

The Study Room Booking System uses a separated frontend and backend architecture. The frontend is implemented as a React single-page application using Vite, TypeScript, Ant Design, React Router, and Axios. The backend is implemented with Django and Django REST Framework, which provide API routing, business logic, database access, and JWT-based authentication. Beyond the main Django backend, the system also includes two supporting gRPC services: a Java service for room recommendation and a Go service for time-slot availability checking. This allows the application to demonstrate both the required Django-based implementation and additional service integration.

### 3.2 Database Models

Replace the current subsection with:

The main database models in the implemented system are `User`, `Building`, `Equipment`, `Room`, `Booking`, and `Review`. The `User` model extends Django’s built-in authentication model and adds a `role` field to distinguish between student and administrator accounts. `Room` records belong to a `Building` and can be linked to multiple `Equipment` items. `Booking` records connect users with rooms and store the booking date, start time, end time, status, and the administrator who processed the request. `Review` records allow students to submit ratings and comments for completed bookings. These models support the complete workflow of authentication, room browsing, booking, approval, cancellation, and review submission.

Do not list separate `Student`, `Role`, or `Permission` models unless you have actually implemented them.

### 3.3 Optional strengthening paragraph

Your current feature list is acceptable, but you can make it stronger by adding one short paragraph like this at the end:

In addition to the core must-have requirements, the final system also implements booking cancellation, room reviews, building management, equipment management, user management, room recommendation, and room availability search. These features extend the original specification and make the implemented system more complete for both students and administrators.

### 3.4 Front-end Interactivity

Replace the current subsection with:

Front-end interactivity is implemented through the React client rather than simple static server-rendered pages. The user interface includes dynamic filtering and pagination on the room browsing page, client-side form validation for login, registration, booking, and management forms, role-based route protection, live status feedback after user actions, and asynchronous API requests using Axios. The system also includes interactive features such as smart room recommendation and availability checking, where the frontend sends requests to backend endpoints and updates the interface based on the returned results. This provides clear evidence of client-side interactivity beyond basic HTML page rendering.

### 3.5 Look and Feel

Replace the current subsection with:

The interface was designed to provide a consistent and responsive experience across desktop and smaller screen sizes. The frontend uses Ant Design components together with custom CSS for typography, spacing, colour, cards, dashboards, tables, and form layouts. The pages use a shared visual language, consistent navigation, and reusable layout components for both student and administrator interfaces. Responsive CSS rules are used so that key pages such as the authentication screens and dashboard layouts adapt to narrower viewports. This helps the application meet the coursework requirement for a polished and responsive user interface.

### 4 Testing

Replace the current testing section with the following text, then add one screenshot of the terminal output if possible:

Testing was carried out using Django REST Framework API tests together with manual checks of the deployed user interface. The automated test suite covers key parts of the booking workflow, authentication, room management, and review logic. These tests verify successful and unsuccessful login, registration, password changes, booking creation, conflict prevention, booking approval and rejection, cancellation, review submission rules, room listing, room detail retrieval, and administrative user management operations.

The automated tests were run on 17 March 2026 using the following command:

`./.venv/bin/python backend/manage.py test bookings reviews users rooms smart_services`

The result was:

`Ran 42 tests in 90.226s`  
`OK`

In addition to automated tests, manual testing was used to confirm the main user journeys in the browser, including logging in, browsing rooms, creating a booking request, approving or rejecting a booking as an administrator, and viewing booking history. Together, these tests provide evidence that the main coursework requirements were implemented correctly.

### 5 Accessibility Report

Use the following version, then add 2 to 3 screenshots as evidence:

The accessibility plan from the design phase was applied to the final implementation through several concrete improvements on key pages including the login page, registration page, and booking-related forms.

First, the system supports keyboard-accessible interaction. Standard form controls, buttons, links, and navigation elements can be reached using the keyboard, and important workflows such as login and booking submission can be completed without relying on a mouse.

Second, visible focus indicators were added to improve keyboard usability. Interactive elements such as buttons, inputs, date pickers, and select controls display a clear focus outline so users can easily see where they are when navigating by keyboard.

Third, forms provide clear labels and instructions. Login, registration, booking, and management forms use labelled fields such as Username, Password, Date, Start Time, and End Time. Some fields also include placeholders or validation messages that help users understand what information is required and how it should be entered.

These changes directly reflect the original accessibility plan and improve usability for keyboard users and users who need clearer form guidance.

Evidence to attach:

- Screenshot of the login form showing labelled inputs
- Screenshot showing visible keyboard focus on a button or input
- Screenshot of a booking or management form showing labelled fields and validation guidance

### 6 Sustainability Report

Your current sustainability section is the weakest part of the draft. Right now it is not fully compliant because it mostly describes possible future improvements instead of reporting actual implemented changes and an after-measurement.

You can use the following baseline table, which was measured on 17 March 2026:

| Page | URL | Performance | Accessibility | Best Practices | SEO |
| --- | --- | ---: | ---: | ---: | ---: |
| Homepage | `http://ttz3305012.uk/` | 46 | 98 | 78 | 83 |
| Login page | `http://ttz3305012.uk/login` | 40 | 94 | 78 | 82 |

You can also report the main findings from the baseline:

- Homepage: First Contentful Paint `9.9s`, Largest Contentful Paint `10.9s`, estimated unused JavaScript savings `1,098 KiB`, estimated unused CSS savings `28 KiB`
- Login page: First Contentful Paint `9.9s`, Largest Contentful Paint `9.9s`, Total Blocking Time `570 ms`, estimated unused JavaScript savings `1,039 KiB`, estimated unused CSS savings `44 KiB`

Use this revised structure:

#### 6.1 Tool and Pages Tested

The sustainability-related performance of the deployed application was evaluated using Google Lighthouse. Two pages were tested: the public homepage and the login page. These pages were selected because they are publicly accessible entry points to the application and represent important user-facing workflows.

#### 6.2 Baseline Measurement

Insert the table above.

#### 6.3 Changes Implemented

This subsection must describe changes you actually implemented. Do not leave it as future suggestions only.

If you make these code changes, you may write about them:

- Introduced route-level code splitting so that large page modules are loaded only when needed
- Reduced unnecessary JavaScript in the initial bundle
- Reduced unused CSS
- Kept frequently requested room and building endpoints cached
- Optimised large images or removed unnecessary assets

Only keep the items that you genuinely implemented.

#### 6.4 After Measurement and Reflection

After making the changes above, run Lighthouse again on the same two pages and add a second results table.

Use this template:

| Page | Performance Before | Performance After | Accessibility Before | Accessibility After | Best Practices Before | Best Practices After |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Homepage | 46 | [fill in] | 98 | [fill in] | 78 | [fill in] |
| Login page | 40 | [fill in] | 94 | [fill in] | 78 | [fill in] |

Then add a short reflection such as:

The main improvement came from reducing the size of the initial frontend payload. After optimisation, the homepage and login page loaded more quickly, which improved the performance score and reduced render delay. Accessibility remained strong because the changes focused mainly on front-end performance rather than altering form semantics or navigation.

### 7 Appendix: Team Contributions and AI Use Statement

Add a clear AI Use Statement. Since this report has now received GenAI-assisted review and language support, you should not claim “no AI use”.

You can use this wording:

Declaration on the use of Generative AI:

- We declare that we have used GenAI for copy-editing and improving the clarity of language in the report.
- We declare that we have used GenAI for limited debugging support, code-quality suggestions, test ideas, and guidance on accessibility and sustainability reporting.

Tool(s) used: ChatGPT  
Parts affected: report drafting/editing, report structure, debugging guidance, testing ideas, accessibility guidance, and sustainability interpretation.  
How correctness was ensured: we checked the final report against the coursework brief, verified the implementation against our own codebase, and ran builds/tests before submission.

Then keep the team contribution statement below it.

## Final submission checklist

- Report exported as PDF
- Public repository URL included
- Public deployed URL included
- Updated design specification includes user stories, architecture diagram, ER diagram, sitemap, and wireframes
- Implementation section matches the real codebase
- Testing section includes unit-test evidence
- Accessibility section names 3 implemented improvements and includes screenshots
- Sustainability section includes before, actual implemented changes, and after
- Appendix includes team contributions and AI Use Statement
- Total report length kept within the brief limits
