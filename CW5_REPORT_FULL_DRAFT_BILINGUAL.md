# CW5 Report Full Draft Bilingual Version

> English text is the suggested report content for submission.  
> Chinese text is for reference only and should not be submitted as part of the final report unless your course explicitly allows bilingual content.

---

# Study Room Booking System
## CW5 Web Application Implementation Report

**English**

Study Room Booking System  
CW5 Web Application Implementation Report  
Team AA  
Course: COMPSCI5012 Internet Technology

**中文参考**

学习室预订系统  
CW5 Web 应用实现报告  
Team AA  
课程：COMPSCI5012 Internet Technology

---

## 1. Introduction, Repository Link and Deployed Application URL
## 1. 引言、代码仓库链接与部署网址

### 1.1 Project Overview
### 1.1 项目概述

**English**

The Study Room Booking System is a web-based application that allows university students to search for study rooms and submit booking requests through an online platform. The aim of the system is to make study room reservation more efficient, organised, and transparent for both students and administrators.

Students can browse rooms and view important information such as building, location, capacity, and equipment. After choosing a suitable room, they can submit a booking request by selecting a date and a time range. The system stores these booking records and allows students to view their current bookings, booking history, and completed sessions that are eligible for review.

The system also includes an administrator interface. Administrators can review booking requests, approve or reject them, and manage core resource data such as rooms, buildings, equipment, and user accounts. This supports better control of room usage and reduces booking conflicts.

Overall, the application provides a practical and user-friendly platform for managing study room reservations while also supporting administrative oversight and system maintenance.

**中文参考**

Study Room Booking System 是一个基于 Web 的应用程序，允许大学生通过在线平台搜索自习室并提交预约请求。该系统的目标是让学生和管理员都能以更高效、更有组织、也更透明的方式完成自习室预约管理。

学生可以浏览房间，并查看建筑、位置、容量和设备等重要信息。选择合适的房间后，用户可以通过选择日期和时间段来提交预约请求。系统会保存这些预约记录，并允许学生查看当前预约、历史预约以及可以提交评价的已完成预约。

系统还包括管理员界面。管理员可以审核预约请求、批准或拒绝请求，并管理房间、建筑、设备和用户账户等核心资源数据。这有助于更好地控制房间使用情况并减少预约冲突。

总体而言，该应用程序为学习室预约管理提供了一个实用且易用的平台，同时也支持管理员进行系统监督和维护。

### 1.2 Adjustments Made to the Original Design Specification
### 1.2 相比原始设计说明所做的调整

**English**

The final implementation follows the main direction of the original design specification, but several adjustments were made during development to improve usability and better support the implemented workflow.

The most important change concerns booking processing. In the implemented system, a booking submitted by a student is first stored with the status **Pending** rather than being immediately confirmed. An administrator must then review the request and decide whether to approve or reject it. This change makes the workflow more realistic and helps prevent scheduling conflicts.

Another change concerns authentication. In the original design, separate login paths were considered for students and administrators. In the final implementation, both roles use a single login interface. After login, the system checks the role of the authenticated user and redirects the user to the appropriate dashboard automatically.

The interface design was also refined compared with the original wireframes. The final system uses a clearer navigation structure, more informative dashboards, status tags for bookings, and dedicated management pages for buildings, equipment, and user accounts. These changes improved clarity and usability while keeping the core design consistent with the original specification.

**中文参考**

最终实现整体上遵循了原始设计说明的主要方向，但在开发过程中做出了一些调整，以提升可用性并更好地支持最终实现的工作流程。

最重要的变化是预约处理流程。在最终系统中，学生提交的预约不会立刻被确认，而是先以 **Pending** 状态保存。之后管理员需要审核该请求，并决定批准还是拒绝。这个改动让流程更加贴近实际，也有助于避免时间冲突。

另一个变化与认证方式有关。在原始设计中，学生和管理员曾考虑使用不同的登录入口。而在最终实现中，两种角色共用同一个登录界面。登录成功后，系统会检查用户角色，并自动跳转到对应的仪表板页面。

与最初线框图相比，界面设计也进行了优化。最终系统使用了更清晰的导航结构、更信息化的仪表板、预约状态标签，以及针对建筑、设备和用户账户的独立管理页面。这些变化提升了系统的清晰度和可用性，同时保持了与原始设计的一致性。

### 1.3 Code Repository Link
### 1.3 代码仓库链接

**English**

Public code repository:  
`https://github.com/HarryBlackCatQAQ/study_room_booking_system.git`

**中文参考**

公开代码仓库：  
`https://github.com/HarryBlackCatQAQ/study_room_booking_system.git`

### 1.4 Deployed Web Application URL
### 1.4 已部署 Web 应用网址

**English**

Public deployed application:  
`http://ttz3305012.uk`

**中文参考**

公开部署网址：  
`http://ttz3305012.uk`

---

## 2. Updated Design Specification
## 2. 更新后的设计说明

### 2.1 System Overview
### 2.1 系统概述

**English**

The Study Room Booking System supports two main user roles: **students** and **administrators**.

Students use the system to browse rooms, view room details, submit booking requests, track booking status, cancel bookings when necessary, and review completed bookings. The student side of the platform is designed to support the complete booking journey, from room discovery to booking history.

Administrators use the system to review booking requests and manage the system’s core data. This includes maintaining room records, building information, equipment lists, and user accounts. The administrator interface is designed to support day-to-day management tasks in a structured and efficient way.

The final system therefore combines a student-facing booking workflow with a role-protected administration interface, allowing both room users and system managers to interact with the same platform in different ways.

**中文参考**

Study Room Booking System 支持两类主要用户角色：**students** 和 **administrators**。

学生使用系统浏览房间、查看房间详情、提交预约请求、跟踪预约状态、在必要时取消预约，以及对已完成预约进行评价。学生端界面旨在支持完整的预约流程，从房间发现到历史记录查看都包含在内。

管理员使用系统审核预约请求，并管理系统的核心数据。这包括维护房间记录、建筑信息、设备列表和用户账户。管理员界面旨在以结构化且高效的方式支持日常管理任务。

因此，最终系统将面向学生的预约流程与受角色保护的管理端界面结合在一起，使普通用户和系统管理者能够以不同方式使用同一平台。

### 2.2 User Stories
### 2.2 用户故事

**English**

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

**中文参考**

更新后的实现基于原始设计说明中的以下优先级用户故事。

**必须实现**

- **M1：** 作为学生，我希望能够登录和注册，这样我的预约是私密的，并且与我的账户绑定。
- **M2：** 作为学生，我希望按容量、位置和设备浏览房间，并查看实时可用性，这样我可以找到合适的学习空间。
- **M3：** 作为学生，我希望通过选择日期、开始时间和结束时间来预订自习室，这样我可以为学习预留特定时间段。
- **M4：** 作为学生，我希望查看我即将到来的预约，以便跟踪预约的时间和地点。此外，我还希望看到预约历史。
- **M5：** 作为管理员，我希望管理房间信息（新增 / 编辑 / 删除），以便房间列表始终保持最新。
- **M6：** 作为管理员，我希望批准或拒绝预约，以便控制对受限资源的访问。

**应该实现**

- **S1：** 作为学生，我希望能够取消预约，这样当计划改变时房间可以重新变为可用。
- **S2：** 作为管理员，我希望查看当前预约的仪表板，以便监控每日房间使用情况。

**可以实现**

- **C1：** 作为学生，我希望能够给房间打分，这样其他学生可以知道哪些房间更好。

**不会实现**

- **W1：** 作为学生，我希望与大学日历集成，以便预约可以自动同步。

### 2.3 System Architecture Diagram
### 2.3 系统架构图

**English**

**[Insert Figure 1: Updated System Architecture Diagram]**

Figure 1 shows the high-level architecture of the implemented system. The frontend is a React single-page application built with Vite and TypeScript. It communicates with a Django backend through REST API endpoints. Django handles authentication, role-based access control, room management, booking workflows, review submission, and administrative operations.

In addition to the main Django service, the system also includes two gRPC-based supporting services. A Java service is used for room recommendation, while a Go service is used for room availability checking. These services are accessed by Django and exposed to the frontend through API endpoints. The implementation also includes caching for selected API responses and a Docker-based deployment configuration with Nginx as the public entry point.

This architecture is more advanced than a simple two-tier web application while still meeting the coursework requirement that the core backend be implemented using Python and Django.

**中文参考**

**[插入图 1：更新后的系统架构图]**

图 1 展示了最终实现系统的高层架构。前端是使用 Vite 和 TypeScript 构建的 React 单页应用。它通过 REST API 与 Django 后端通信。Django 负责认证、基于角色的访问控制、房间管理、预约流程、评价提交和管理端操作。

除了主要的 Django 服务之外，系统还包括两个基于 gRPC 的辅助服务。Java 服务用于房间推荐，而 Go 服务用于房间可用时间段查询。这些服务由 Django 调用，并通过 API 端点向前端暴露结果。实现中还对部分 API 响应使用了缓存，并采用基于 Docker 的部署配置，由 Nginx 作为公共入口。

该架构比简单的双层 Web 应用更复杂，但同时仍满足课程要求，即核心后端必须使用 Python 和 Django 实现。

### 2.4 Data Design
### 2.4 数据设计

**English**

**[Insert Figure 2: Final ER Diagram]**

The implemented system uses a relational data model centred around six main entities: **User**, **Building**, **Equipment**, **Room**, **Booking**, and **Review**.

The **User** model extends Django’s authentication system and includes a `role` field to distinguish between students and administrators. A **Building** can contain multiple **Room** records, and a **Room** can be linked to multiple **Equipment** items. A **Booking** connects a student user to a room and stores the booking date, time range, status, and the administrator who processed the request. A **Review** allows a student to submit a rating and comment for a completed approved booking.

This data design supports the full workflow of authentication, room browsing, booking submission, booking approval, cancellation, and review posting while keeping the model structure consistent with the implemented system.

**中文参考**

**[插入图 2：最终 ER 图]**

最终实现使用关系型数据模型，主要围绕六个实体展开：**User**、**Building**、**Equipment**、**Room**、**Booking** 和 **Review**。

**User** 模型扩展了 Django 的认证系统，并包含一个 `role` 字段，用于区分学生和管理员。一个 **Building** 可以包含多个 **Room** 记录，而一个 **Room** 可以关联多个 **Equipment** 项。一个 **Booking** 将学生用户与房间关联起来，并保存预约日期、时间范围、状态以及处理该请求的管理员。一个 **Review** 允许学生对已完成且已批准的预约提交评分和评论。

这样的数据设计支持认证、房间浏览、预约提交、预约审批、取消预约和评价发布等完整流程，同时保持与最终实现一致的模型结构。

### 2.5 Site Structure
### 2.5 网站结构

**English**

**[Insert Figure 3: Site Map]**

The site structure is organised around role-based navigation.

On the student side, users can access the landing page, login and registration pages, student dashboard, room browsing page, room detail page, my bookings page, booking history page, and profile page.

On the administrator side, authenticated admin users can access the admin dashboard, booking request management page, room management page, building management page, equipment management page, user management page, and profile page.

This structure keeps the student journey simple while also separating administrative tasks into focused management pages.

**中文参考**

**[插入图 3：网站地图]**

网站结构基于角色导航进行组织。

在学生端，用户可以访问首页、登录和注册页面、学生仪表板、房间浏览页、房间详情页、我的预约页、预约历史页以及个人资料页。

在管理员端，经过认证的管理员可以访问管理员仪表板、预约请求管理页、房间管理页、建筑管理页、设备管理页、用户管理页以及个人资料页。

这种结构使学生端使用流程保持简洁，同时也将管理员任务拆分为更聚焦的管理页面。

### 2.6 User Interface Design
### 2.6 用户界面设计

**English**

**[Insert Figure 4: Wireframes / Key UI Screens]**

The early wireframes were used as the basis for the final interface design. They guided the layout of the login page, dashboard pages, room browsing interface, booking forms, and administrator management pages.

During implementation, the wireframes were refined into a more polished and consistent interface using reusable layouts, dashboard cards, status tags, form components, and responsive page sections. The final interface remains aligned with the design intention of the original specification while providing a more complete and usable user experience.

**中文参考**

**[插入图 4：线框图 / 关键界面截图]**

早期线框图被用作最终界面设计的基础。它们指导了登录页、仪表板页面、房间浏览界面、预约表单和管理员管理页面的布局。

在实现过程中，这些线框图被进一步完善，最终形成了一个更精致、更一致的界面，使用了可复用布局、仪表板卡片、状态标签、表单组件以及响应式页面结构。最终界面既保持了原始设计意图，又提供了更完整和更易用的用户体验。

### 2.7 Changes from the Original Design Specification
### 2.7 相比原始设计说明的变化

**English**

Although the implemented system follows the original design closely, several changes were made during development.

**中文参考**

尽管最终实现整体上与原始设计保持一致，但在开发过程中仍做出了一些调整。

#### 2.7.1 Authentication Interface Change
#### 2.7.1 认证界面的变化

**English**

In the original design, separate login interfaces were considered for students and administrators. In the final implementation, this was simplified into a single login page. After successful authentication, the system checks the role of the user and redirects them to the correct dashboard automatically.

This change simplified the login process and reduced unnecessary duplication in the interface.

**[Insert Figure 5: Implemented Login Interface]**

**中文参考**

在原始设计中，学生和管理员曾考虑使用不同的登录界面。而在最终实现中，这一设计被简化为单一登录页面。认证成功后，系统会检查用户角色，并自动跳转到正确的仪表板页面。

这一变化简化了登录流程，也减少了界面上的重复设计。

**[插入图 5：最终实现的登录界面]**

#### 2.7.2 Student Interface Improvements
#### 2.7.2 学生端界面的改进

**English**

Compared with the original wireframes, the final student interface provides more guidance and more visible system feedback.

The student dashboard now presents booking-related summary information, quick access actions, and guidance for common tasks. The room browsing interface includes filters, search, and room suggestion features. The booking history page also supports the review workflow for completed sessions.

These additions make the student interface more informative and easier to use than the original draft design.

**[Insert Figure 6: Implemented Student Dashboard]**

**中文参考**

与最初的线框图相比，最终学生端界面提供了更多引导信息和更明显的系统反馈。

学生仪表板现在展示了与预约相关的摘要信息、快捷操作入口以及常见任务引导。房间浏览界面包含筛选、搜索和房间推荐功能。预约历史页面还支持对已完成预约进行评价的流程。

这些新增内容使学生端界面比最初设计更具信息性，也更容易使用。

**[插入图 6：最终实现的学生仪表板]**

#### 2.7.3 Administrative System Expansion
#### 2.7.3 管理端系统扩展

**English**

The administrative interface was expanded beyond the original wireframes. In addition to booking approval and room management, the final implementation includes dedicated pages for managing buildings, equipment, and user accounts.

These additions make the system more complete from an administrative perspective and provide better support for maintaining study room resources and user data.

**[Insert Figure 7: Implemented Administrative Interface]**

**中文参考**

管理员界面相较于原始线框图有了进一步扩展。除了预约审批和房间管理之外，最终实现还包括建筑管理、设备管理和用户账户管理等独立页面。

这些新增功能让系统从管理角度看更加完整，也更有利于维护学习室资源和用户数据。

**[插入图 7：最终实现的管理员界面]**

---

## 3. Implementation Highlights
## 3. 实现亮点

### 3.1 System Architecture
### 3.1 系统架构

**English**

The final system uses a separated frontend and backend architecture.

The frontend is implemented as a React single-page application using **React**, **Vite**, **TypeScript**, **React Router**, **Axios**, and **Ant Design**. This frontend is responsible for rendering the user interface, handling client-side routing, validating user input, and performing asynchronous API requests.

The backend is implemented using **Django** and **Django REST Framework**. It provides the application’s main business logic, API endpoints, database interaction, role-based permissions, and authentication features. Authentication is handled using JWT tokens so that protected API endpoints can be accessed securely from the frontend.

Beyond the core Django backend, the project also includes two supporting services. A **Java gRPC service** provides room recommendation functionality, and a **Go gRPC service** provides availability searching for requested time ranges. These services are called by Django and exposed to the frontend through API endpoints.

**中文参考**

最终系统采用前后端分离架构。

前端实现为 React 单页应用，使用了 **React**、**Vite**、**TypeScript**、**React Router**、**Axios** 和 **Ant Design**。前端负责渲染用户界面、处理客户端路由、校验用户输入以及执行异步 API 请求。

后端使用 **Django** 和 **Django REST Framework** 实现。它提供应用的核心业务逻辑、API 端点、数据库交互、基于角色的权限控制以及认证功能。认证通过 JWT token 完成，从而使前端可以安全地访问受保护的 API。

除了核心 Django 后端之外，项目还包括两个辅助服务。一个 **Java gRPC 服务** 用于房间推荐功能，另一个 **Go gRPC 服务** 用于按时间范围查询房间可用性。这些服务由 Django 调用，并通过 API 端点向前端提供结果。

### 3.2 Main Components
### 3.2 主要组件

**English**

The implemented system contains the following main components:

- **Frontend application:** student and administrator interfaces built with React.
- **Authentication module:** registration, login, profile, and password change endpoints.
- **Room management module:** room listing, room detail, room creation, update, and deletion.
- **Booking module:** booking creation, booking listing, cancellation, approval, and rejection.
- **Review module:** room review listing and review submission after completed approved bookings.
- **Administrative management module:** building, equipment, and user account management.
- **Smart services module:** room recommendation and availability search via gRPC-integrated backend endpoints.

Each major feature is separated into reusable pages, API modules, backend apps, serializers, and service layers, which helps keep the implementation organised and maintainable.

**中文参考**

最终实现的系统包含以下主要组件：

- **前端应用：** 使用 React 构建的学生端和管理员端界面。
- **认证模块：** 包括注册、登录、个人资料和密码修改接口。
- **房间管理模块：** 包括房间列表、房间详情、房间创建、更新和删除。
- **预约模块：** 包括预约创建、预约列表、取消、批准和拒绝。
- **评价模块：** 包括房间评价列表，以及对已完成且已批准预约的评价提交。
- **管理模块：** 包括建筑、设备和用户账户管理。
- **智能服务模块：** 通过集成 gRPC 后端端点实现房间推荐和可用性查询。

每个主要功能都被拆分为可复用页面、API 模块、后端 app、serializer 和 service 层，这有助于让实现保持清晰且易于维护。

### 3.3 Key Features
### 3.3 核心功能

**English**

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

**中文参考**

**用户认证（M1）**  
用户认证通过基于 Django 的后端逻辑和 JWT API 认证实现。学生和管理员都可以注册和登录，系统会根据角色将认证成功的用户跳转到正确的仪表板页面。

**房间浏览（M2）**  
学生可以在房间列表页浏览房间，并查看建筑、位置、容量和设备等详细信息。界面还支持筛选和搜索，帮助用户更快找到合适的房间。

**房间预约（M3）**  
学生可以通过选择房间、日期、开始时间和结束时间来提交预约请求。后端会验证该请求，并防止时间冲突的重叠预约。

**预约跟踪与历史（M4）**  
学生可以查看当前预约请求和历史预约。历史页面还支持对已完成且已批准的预约进行评价。

**房间管理（M5）**  
管理员可以通过独立管理页面创建、更新和删除房间记录。

**预约审批（M6）**  
管理员可以审核预约请求并进行批准或拒绝。系统会记录批准和拒绝后的状态变化。

除了这些核心必做功能之外，最终系统还实现了取消预约、房间评价、建筑管理、设备管理、用户管理、房间推荐和房间可用性查询。

### 3.4 Front-end Interactivity
### 3.4 前端交互性

**English**

The application clearly demonstrates client-side interactivity beyond static page rendering.

The React frontend provides dynamic room filtering and pagination, form validation, asynchronous API requests, role-based route protection, and live interface updates after user actions such as login, booking creation, or request approval. The booking forms, login forms, and management forms all validate required input before submission.

The system also includes two interactive smart features. The room recommendation interface submits form data asynchronously and displays suggested rooms based on the selected criteria. The availability checking interface allows users to query a time range and immediately view available rooms without requiring a full page reload.

These behaviours provide clear evidence that the application meets the coursework requirement for frontend interactivity.

**中文参考**

该应用清楚地展示了超越静态页面渲染的客户端交互性。

React 前端提供了动态房间筛选与分页、表单验证、异步 API 请求、基于角色的路由保护，以及在登录、创建预约或审批请求后对界面的实时更新。预约表单、登录表单和管理表单都会在提交前验证必填输入。

系统还包括两个交互式智能功能。房间推荐界面会异步提交表单数据，并根据所选条件展示推荐房间。可用性查询界面允许用户输入时间范围并立即查看可用房间，而不需要整页刷新。

这些行为清楚表明该应用满足课程对前端交互性的要求。

### 3.5 Look and Feel
### 3.5 界面观感

**English**

The interface was designed to be polished, consistent, and responsive.

The project uses Ant Design components together with custom CSS for layouts, forms, cards, tables, navigation, status displays, and page sections. Shared layout components are used for both student and administrator views, helping the system maintain a consistent visual language.

The colour palette, spacing, typography, and dashboard layout were designed to make the interface more refined than the original wireframes. Responsive CSS is also used so that major pages, particularly authentication and dashboard layouts, adapt to smaller screens. As a result, the final application provides a more professional and coherent user experience.

**中文参考**

界面被设计为更精致、一致且具有响应式效果。

项目使用了 Ant Design 组件，并结合自定义 CSS 来实现布局、表单、卡片、表格、导航、状态显示和页面分区。学生端和管理员端都使用共享布局组件，这有助于系统保持统一的视觉语言。

颜色方案、间距、字体排版以及仪表板布局都经过设计，使最终界面比最初线框图更精致。项目还使用响应式 CSS，让主要页面，尤其是认证页和仪表板布局，能够适应较小屏幕。因此，最终应用提供了更专业且更统一的用户体验。

### 3.6 Code Quality and Organisation
### 3.6 代码质量与组织结构

**English**

The codebase is organised to support separation of concerns and reusability.

On the frontend, routing, API access, reusable components, page components, styles, and utility functions are separated into different modules. On the backend, functionality is divided into dedicated Django apps including users, rooms, bookings, reviews, and smart services.

Reusable serializers, API client modules, and shared layout components reduce duplication and make the code easier to maintain. API configuration is also kept separate from page code so that frontend requests are not hard-coded directly inside UI components. This structure helps the implementation satisfy the coursework expectations for readable and well-organised code.

**中文参考**

代码库的组织方式支持关注点分离和可复用性。

在前端部分，路由、API 访问、可复用组件、页面组件、样式和工具函数都被拆分到不同模块中。在后端部分，功能被划分到不同的 Django app 中，包括 users、rooms、bookings、reviews 和 smart services。

可复用的 serializer、API 客户端模块和共享布局组件减少了重复代码，也使项目更易维护。API 配置也与页面代码分离，从而避免把前端请求硬编码到 UI 组件中。这种结构有助于满足课程对代码可读性和组织性的要求。

---

## 4. Testing
## 4. 测试

**English**

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

**中文参考**

测试通过自动化 API 测试和基于浏览器的手动测试相结合的方式完成。

自动化测试使用 Django REST Framework 的测试工具实现。这些测试主要关注认证、预约、房间和评价模块中的重要业务规则与 API 行为。

自动化测试覆盖以下内容：

- 用户注册和登录
- 无效登录处理
- 个人资料获取与密码修改
- 房间列表和房间详情获取
- 管理员创建房间权限
- 预约创建
- 预约冲突防止
- 预约取消
- 管理员审批和拒绝预约
- 过期 pending 预约的自动拒绝
- 评价创建规则
- 对未完成或已评价预约的限制
- 管理员用户管理行为

自动化测试于 **2026 年 3 月 17 日** 通过以下命令运行：

```bash
./.venv/bin/python backend/manage.py test bookings reviews users rooms smart_services
```

测试结果为：

```text
Ran 42 tests in 90.226s
OK
```

除了自动化测试之外，我们还进行了手动测试，以验证浏览器中的完整用户流程。这包括登录、浏览房间、提交预约请求、以管理员身份批准或拒绝预约、查看预约历史，以及在预约完成后提交房间评价。

这些自动化和手动测试共同证明，最终实现的系统能够正确满足课程中的主要功能要求。

**[插入图 8：自动化测试输出截图]**

---

## 5. Accessibility Report
## 5. 无障碍报告

**English**

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

**中文参考**

设计阶段制定的无障碍计划在最终系统中通过若干实际的界面改进得到了落实。这些改进主要体现在登录页面、与预约相关的表单以及其他重要用户输入流程中。

### 5.1 键盘可访问性

系统支持对重要用户任务的键盘操作。用户可以通过键盘在表单字段、按钮和链接之间移动，并且像登录和提交预约这样的操作都可以在不依赖鼠标的情况下完成。

这提升了仅使用键盘用户的可用性，也使整个界面的交互更加无障碍。

**[插入图 9：显示键盘导航或焦点元素的截图]**

### 5.2 可见焦点指示

系统增加了可见的焦点样式，使用户在使用键盘导航时可以清楚看到当前选中的交互元素。按钮、输入框、选择组件以及日期 / 时间选择器都会显示清晰的焦点边框。

这项改动直接响应了无障碍计划，使键盘导航更容易追踪。

**[插入图 10：显示焦点边框的截图]**

### 5.3 清晰的标签和输入引导

系统中的表单都使用了清晰的标签和辅助说明。例如，登录页面包含 **Username** 和 **Password** 标签，预约表单包含 **Date**、**Start Time** 和 **End Time** 标签。部分字段还带有 placeholder 或验证信息，以帮助用户理解需要输入什么内容。

这减少了用户输入错误，也为需要更清晰表单语义的用户提升了可访问性。

**[插入图 11：显示登录或预约表单标签的截图]**

### 5.4 总结

这些改进表明，无障碍计划已经在最终系统中被真正实现，而不只是停留在设计阶段。这些变化聚焦于最终界面中可见、可验证的实际可用性改进，并可以通过关键页面截图进行证明。

---

## 6. Sustainability Report
## 6. 可持续性报告

**English**

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

**中文参考**

应用的可持续性相关性能使用 **Google Lighthouse** 进行了评估。评估重点放在面向用户的页面上，因为作业要求至少对两个页面提供性能证据，其中包括首页和一个核心功能页面。

### 6.1 使用的工具和测试页面

以下页面于 **2026 年 3 月 17 日** 进行了测试：

- 首页：`http://ttz3305012.uk/`
- 登录页：`http://ttz3305012.uk/login`

之所以选择这些页面，是因为它们是应用的公开入口页面，并且代表了系统中重要的面向用户部分。

### 6.2 基线测量

Lighthouse 的基线结果如下：

| 页面 | 性能 | 无障碍 | 最佳实践 | SEO |
| --- | ---: | ---: | ---: | ---: |
| 首页 | 46 | 98 | 78 | 83 |
| 登录页 | 40 | 94 | 78 | 82 |

基线结果表明，无障碍表现已经相对较好，但性能较弱。Lighthouse 识别出的主要问题是前端 JavaScript 包过大。例如，Lighthouse 估计首页存在约 **1,098 KiB** 的未使用 JavaScript，登录页存在约 **1,039 KiB** 的未使用 JavaScript。

### 6.3 已实施的改进

为了提升与可持续性相关的性能，前端应进行优化，以减少初始页面加载时需要加载的 JavaScript 数量。适合写入此处的真实优化包括：

- 对页面组件引入按路由拆分加载
- 减少初始 bundle 中不必要的 JavaScript
- 在可能情况下减少未使用 CSS
- 对常用的房间和建筑接口保持缓存

**重要：** 这一小节只能描述最终提交版本中真实已经做过的改动。如果在提交前你们完成了额外优化，需要把这里更新成真实完成的内容。

### 6.4 优化后测量与反思

在完成性能优化后，应再次对同样的两个页面运行 Lighthouse，并在下表中报告更新后的结果。

| 页面 | 优化前性能 | 优化后性能 | 优化前无障碍 | 优化后无障碍 | 优化前最佳实践 | 优化后最佳实践 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 首页 | 46 | **[填写]** | 98 | **[填写]** | 78 | **[填写]** |
| 登录页 | 40 | **[填写]** | 94 | **[填写]** | 78 | **[填写]** |

在填入真实数值后，你可以使用下面这段反思文字：

主要改进来自于减少初始页面加载时需要处理的前端代码量。经过优化后，测试页面加载更高效，从而提升了性能分数并减少了不必要的资源消耗。无障碍分数依旧保持较高水平，因为优化工作主要集中在 bundle 大小和页面交付方式上，而不是改变表单语义或导航行为。

**[插入图 12：Lighthouse 基线截图]**  
**[插入图 13：Lighthouse 优化后截图]**

---

## 7. Appendix: Team Contributions and AI Use Statement
## 7. 附录：团队贡献与 AI 使用声明

### 7.1 Team Contributions
### 7.1 团队贡献

**English**

- **Haorong Huang** – Database design and system architecture (34%)
- **Haozhe Zhang** – User stories and system overview (33%)
- **Enyang Tu** – Sitemap, wireframes, and accessibility design (33%)

**中文参考**

- **Haorong Huang** – 数据库设计与系统架构（34%）
- **Haozhe Zhang** – 用户故事与系统概述（33%）
- **Enyang Tu** – 站点地图、线框图与无障碍设计（33%）

### 7.2 AI Use Statement
### 7.2 AI 使用声明

**English**

Declaration on the use of Generative AI:

- We declare that we have used GenAI for copy-editing and improving the clarity of language in the report.
- We declare that we have used GenAI for limited debugging support, code-quality suggestions, test ideas, and guidance on accessibility and sustainability reporting.

Tool(s) used: ChatGPT  
Parts affected: report drafting/editing, report structure, debugging guidance, testing ideas, accessibility guidance, and sustainability interpretation.  
How correctness was ensured: we checked the final report against the coursework brief, verified the report content against our own codebase, and validated implementation details through builds, tests, and manual review before submission.

**中文参考**

关于生成式 AI 使用的声明：

- 我们声明，我们使用了生成式 AI 来进行报告的语言润色和表达清晰度提升。
- 我们声明，我们还在有限范围内使用了生成式 AI 来获得调试支持、代码质量建议、测试思路，以及无障碍和可持续性报告方面的指导。

使用工具：ChatGPT  
影响部分：报告撰写 / 编辑、报告结构、调试指导、测试思路、无障碍指导和可持续性分析。  
正确性保证方式：我们将最终报告与 coursework brief 进行对照检查，依据自己的代码库核对报告内容，并通过构建、测试和人工复查来验证实现细节。

---

## Final Notes Before Exporting to PDF
## 导出 PDF 前的最终提醒

**English**

- Replace all figure placeholders with real screenshots or diagrams.
- Keep the section page limits in mind when transferring this draft into Word.
- Do not claim any sustainability improvement as implemented unless it was actually implemented and re-measured.
- If the ER diagram still shows entities not present in the final code, update it before submission.

**中文参考**

- 把所有 Figure 占位符都替换成真实截图或图表。
- 把这份草稿转进 Word 时，要注意各章节页数限制。
- 没有真实实现并重新测量的可持续性优化，不要写成“已经完成”。
- 如果 ER 图里仍然画了最终代码中不存在的实体，请在提交前更新。
