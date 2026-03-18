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

The implemented site structure keeps the original role-based layout. Public users first access the landing page and the login / register pages, and are then redirected to either the student dashboard or the administrator dashboard.

Compared with the original design, the student side now separates Browse Rooms, My Bookings, Booking History, and Profile, and also includes room detail, availability check, booking, cancellation, and review actions. On the administrator side, Room Management and Booking Requests are retained, while Building Management, Equipment Management, User Management, and Profile / Security pages are added.

This updated structure remains clear and simple, while reflecting the implemented routes more accurately than the original design version.

**中文参考**

**[插入图 3：网站地图]**

最终实现的网站结构保留了原始设计中基于角色的分层布局。公共用户首先访问首页以及登录 / 注册页面，随后系统会根据用户角色跳转到学生仪表板或管理员仪表板。

与原始设计相比，学生端现在将房间浏览、我的预约、预约历史和个人资料分为独立页面，并补充了房间详情、可用性检查、预约、取消预约和评价等操作。管理员端则在保留房间管理和预约请求页面的基础上，新增了建筑管理、设备管理、用户管理以及个人资料 / 安全设置页面。

整体而言，更新后的站点结构在保持清晰简洁的同时，也比原始设计更准确地反映了实际实现的路由和用户流程。

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

The implemented system uses a multi-service web architecture. The frontend is a React single-page application built with **React**, **Vite**, **TypeScript**, **React Router**, **Axios**, and **Ant Design**, and it handles client-side routing, forms, and asynchronous UI updates.

The main backend is implemented with **Django** and **Django REST Framework**, which provide API routing, business logic, database access, role-based permissions, and JWT-based authentication. The deployed architecture also includes **Nginx** as the public entry point, a **PostgreSQL** primary database with read replicas, and a **Redis Cluster** used for caching and locking.

In addition, Django integrates with two supporting gRPC services: a **Java** service for room recommendation and a **Go** service for time-slot availability checking. This makes the final implementation broader than a simple two-tier web application while still keeping Django as the core application backend.

**中文参考**

最终实现采用了多服务 Web 架构。前端是使用 **React**、**Vite**、**TypeScript**、**React Router**、**Axios** 和 **Ant Design** 构建的单页应用，负责客户端路由、表单交互和异步界面更新。

核心后端由 **Django** 和 **Django REST Framework** 实现，负责 API 路由、业务逻辑、数据库访问、基于角色的权限控制以及 JWT 认证。部署层面还包括作为统一入口的 **Nginx**、带只读副本的 **PostgreSQL** 主数据库，以及用于缓存和锁机制的 **Redis Cluster**。

此外，Django 还集成了两个 gRPC 辅助服务：一个基于 **Java** 的房间推荐服务，以及一个基于 **Go** 的时间段可用性查询服务。因此，最终系统比简单的前后端两层架构更完整，同时仍然以 Django 作为核心应用后端。

### 3.2 Main Components
### 3.2 主要组成部分

**English**

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

**中文参考**

最终系统主要由以下部分组成：

- **前端应用：** 使用 React 构建的学生端和管理员端界面。
- **Django REST API 后端：** 负责核心业务逻辑、权限控制、认证和数据访问。
- **认证与个人资料模块：** 包括学生注册、登录、个人资料查看和密码修改。
- **房间资源管理模块：** 包括房间、建筑和设备数据管理。
- **预约生命周期模块：** 包括预约创建、审批、拒绝、取消，以及过期待处理预约的同步处理。
- **评价模块：** 包括房间评价列表以及对符合条件的已完成预约提交评价。
- **智能服务模块：** 通过集成 gRPC 后端端点实现房间推荐和可用性查询。
- **基础设施层：** 包括 Nginx、PostgreSQL 主从部署，以及基于 Redis 的缓存支持。

每个主要功能都被拆分为可复用页面、API 模块、后端 app、serializer 和 service 层，从而使实现结构更清晰，也更便于维护。

### 3.3 Key Features
### 3.3 核心功能

**English**

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

**中文参考**

**用户认证（M1）**  
学生可以通过公开注册页注册账户，学生和管理员都可以使用基于 JWT 的认证方式登录。登录后，系统会根据用户角色跳转到对应的仪表板。管理员账户不是通过公开注册创建，而是通过管理员用户管理流程维护。

**房间浏览（M2）**  
学生可以通过搜索、筛选、分页和智能推荐面板浏览房间，并进入房间详情页查看建筑信息、容量、设备、评分和评论。

**房间预约（M3）**  
学生可以在房间详情页中先查询指定时间段的可用性，再提交预约请求。后端会校验预约规则，并阻止时间冲突的重复预约。

**预约跟踪与历史（M4）**  
`My Bookings` 用于查看待处理和即将到来的预约，并支持取消。`Booking History` 用于保存已完成、已拒绝和已取消的记录，并允许符合条件的已完成预约提交评价。

**房间管理（M5）**  
管理员可以创建、编辑和删除房间记录。最终实现还通过独立页面将这一管理流程扩展到了建筑和设备数据。

**预约审批（M6）**  
管理员可以在预约请求页面中审核预约并执行批准或拒绝操作。此外，后端的预约生命周期逻辑还会同步并自动拒绝过期的待处理预约。

除核心必做功能外，最终系统还实现了个人资料管理、密码修改、房间评价、建筑管理、设备管理、用户管理、房间推荐和可用性查询等功能。

### 3.4 Front-end Interactivity
### 3.4 前端交互性

**English**

The application clearly demonstrates client-side interactivity beyond static page rendering.

The React frontend supports dynamic room filtering and pagination, role-based route protection, validation on authentication, booking, and management forms, modal-based booking and review flows, and live feedback after asynchronous actions such as login, booking submission, approval, or review creation.

The recommendation panel and availability checker both send asynchronous requests and update the interface without requiring a full page reload. These behaviours provide clear evidence that the application meets the coursework requirement for frontend interactivity.

**中文参考**

该应用清楚地体现了超越静态页面渲染的前端交互能力。

React 前端支持动态房间筛选与分页、基于角色的路由保护、认证表单/预约表单/管理表单的输入校验、基于弹窗的预约和评价流程，以及登录、提交预约、审批和提交评价等异步操作后的即时界面反馈。

推荐面板和可用性查询模块都会异步发送请求，并在不刷新整页的情况下更新界面。这些行为清楚表明该系统满足课程对前端交互性的要求。

### 3.5 Look and Feel
### 3.5 界面观感

**English**

The interface was designed to be polished, consistent, and responsive.

The project uses Ant Design components together with custom CSS for dashboards, cards, tables, navigation, status displays, and forms. Shared student and administrator layout components help maintain a consistent visual language across the system.

Responsive CSS rules and flexible layouts allow key pages such as the authentication screens, dashboards, room pages, and record tables to adapt to smaller screens. As a result, the final application provides a more professional and coherent user experience than the original wireframes.

**中文参考**

界面的设计目标是精致、一致且具有响应式表现。

项目使用了 Ant Design 组件，并结合自定义 CSS 实现仪表板、卡片、表格、导航、状态展示和表单等界面元素。学生端和管理员端共享布局组件，从而保持统一的视觉语言。

响应式 CSS 规则和灵活布局使认证页面、仪表板、房间页面和记录表格等关键页面能够适配较小屏幕。因此，最终应用在用户体验上比最初的线框图更加完整和专业。

### 3.6 Code Quality and Organisation
### 3.6 代码质量与组织结构

**English**

The codebase is organised to support separation of concerns and reusability.

On the frontend, routes, page components, API clients, layouts, reusable components, styles, and types are separated into dedicated modules. API configuration uses a configurable base URL and a token-refresh interceptor rather than hard-coded requests inside UI components.

On the backend, functionality is divided into dedicated Django apps including `users`, `rooms`, `bookings`, `reviews`, and `smart_services`, with serializers, services, permissions, database routing, and cache configuration kept in separate modules. Route-level lazy loading was also introduced so that large page modules are loaded only when needed. This structure supports maintainability, reuse, and easier testing.

**中文参考**

代码库的组织方式强调关注点分离和可复用性。

在前端部分，路由、页面组件、API 客户端、布局组件、可复用组件、样式和类型定义都被拆分到独立模块中。API 配置采用可配置的基础地址和 token 刷新拦截器，而不是把请求硬编码在 UI 组件内部。

在后端部分，功能被划分到独立的 Django app 中，包括 `users`、`rooms`、`bookings`、`reviews` 和 `smart_services`，并将 serializer、service、permission、数据库路由和缓存配置进一步拆分到单独模块。项目还引入了按路由懒加载，使大型页面模块只在需要时加载。这样的结构有助于维护、复用和测试。

---

## 4. Testing
## 4. 测试

**English**

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

**中文参考**

测试采用了自动化 API 测试和基于浏览器的人工验证相结合的方式。

自动化测试使用 Django REST Framework 的测试工具实现，覆盖了认证、个人资料获取、密码修改、房间列表与详情获取、管理员房间权限、预约创建、预约冲突防止、取消预约、预约审批与拒绝、过期待处理预约的自动拒绝、评价提交规则以及管理员用户管理等内容。

本报告引用的自动化测试运行于 **2026 年 3 月 17 日**，使用以下命令：

```bash
./.venv/bin/python backend/manage.py test bookings reviews users rooms smart_services
```

记录结果为：

```text
Ran 42 tests in 90.226s
OK
```

`smart_services` app 被包含在测试命令中以统一运行整个后端测试套件，但推荐和可用性查询流程主要通过人工端到端测试进行验证。

人工测试覆盖了浏览器中的主要用户流程，包括学生注册与登录、浏览房间、查看房间详情与可用性、提交预约、取消预约、管理员审批或拒绝预约、查看预约历史，以及在符合条件的已完成预约后提交评价。

这些自动化和人工测试共同说明，最终系统能够正确满足课程要求中的主要功能。

**[插入图 8：自动化测试输出截图]**

---

## 5. Accessibility Report
## 5. 无障碍报告

**English**

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

**中文参考**

设计阶段提出的无障碍计划在最终系统中得到了落实，具体体现在登录、注册、预约、个人资料和管理表单等关键页面的多项改进中。

### 5.1 键盘可访问性

重要流程可以仅通过键盘完成。用户可以在链接、按钮、输入框、下拉选择框和日期选择器之间移动，而不依赖鼠标；登录、注册、提交预约和管理表单等任务都可以通过标准键盘导航完成。

**[插入图 9：键盘导航或焦点元素截图]**

### 5.2 可见焦点指示

系统增加了明显的焦点样式来提升键盘可用性。按钮、输入框、选择控件和日期选择组件都会显示清晰的焦点轮廓，使用户更容易判断当前处于激活状态的元素。

**[插入图 10：可见焦点轮廓截图]**

### 5.3 清晰的标签与输入引导

系统中的表单都使用了清晰的标签和辅助提示。登录、注册、预约、修改密码和管理表单均使用了明确标注的字段，部分输入框还带有占位提示或校验信息，帮助用户理解需要填写的内容。

**[插入图 11：带标签的登录或预约表单截图]**

### 5.4 总结

这些改进说明无障碍计划已经在最终系统中真正落地，而不是只停留在设计阶段。相关变化聚焦于可见且可验证的实际可用性提升，并能够通过实现界面的截图加以证明。

---

## 6. Sustainability Report
## 6. 可持续性报告

**English**

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

**中文参考**

本项目的可持续性相关性能评估使用 **Google Lighthouse 13.0.3** 完成。为保持测量环境一致，测试于 **2026 年 3 月 18 日** 在基于提交版前端代码构建的本地 production preview 上进行。

### 6.1 使用工具与测试页面

测试了以下两个页面：

- 首页：`http://127.0.0.1:4173/`
- 登录页：`http://127.0.0.1:4173/login`

之所以选择这两个页面，是因为它们是系统对外公开的入口页面，也满足作业对至少两个面向用户页面进行测量的要求。

### 6.2 基线测量

优化前的 Lighthouse 基线结果如下：

| 页面 | 性能 | 无障碍 | Best Practices | SEO |
| --- | ---: | ---: | ---: | ---: |
| 首页 | 70 | 98 | 100 | 83 |
| 登录页 | 78 | 94 | 100 | 82 |

基线结果表明，主要问题在于前端初始载荷较大。首页的 **First Contentful Paint** 为 **4.1 s**，**Largest Contentful Paint** 为 **5.1 s**，**Total Blocking Time** 为 **130 ms**，并存在约 **338 KiB** 的未使用 JavaScript。登录页的 **First Contentful Paint** 为 **3.5 s**，**Largest Contentful Paint** 为 **4.1 s**，**Total Blocking Time** 为 **130 ms**，约有 **319 KiB** 的未使用 JavaScript，以及约 **15 KiB** 的未使用 CSS。

### 6.3 已实施的改进

本报告中实际完成并重新测量的一项优化是：在 React 路由中使用 `React.lazy` 和 `Suspense` 实现按路由代码分割，使大型页面模块仅在需要时加载。

这一改动减少了初始页面加载阶段需要处理的 JavaScript 体积。优化前，Vite 生产构建生成的主 JavaScript 文件大小为 **1,474.14 kB**（gzip 后 **452.99 kB**）；优化后，最大的共享 JavaScript chunk 降至 **669.62 kB**（gzip 后 **222.07 kB**），其余页面代码按路由单独加载。项目本身也已经对常用的房间和评论接口使用了基于 Redis 的缓存，但本节讨论的可测量提升主要来自新的前端加载策略。

### 6.4 优化后测量与反思

在实现按路由代码分割之后，对同样两个页面再次运行 Lighthouse，结果如下：

| 页面 | 优化前性能 | 优化后性能 | 优化前无障碍 | 优化后无障碍 | 优化前 Best Practices | 优化后 Best Practices |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 首页 | 70 | 84 | 98 | 98 | 100 | 100 |
| 登录页 | 78 | 83 | 94 | 94 | 100 | 100 |

优化后的加载指标也有明显提升。首页的 **First Contentful Paint** 从 **4.1 s** 降到 **2.8 s**，**Largest Contentful Paint** 从 **5.1 s** 降到 **3.8 s**，**Total Blocking Time** 从 **130 ms** 降到 **30 ms**，未使用 JavaScript 从约 **338 KiB** 降到约 **116 KiB**。登录页的 **First Contentful Paint** 从 **3.5 s** 降到 **2.8 s**，**Largest Contentful Paint** 从 **4.1 s** 降到 **3.9 s**，**Total Blocking Time** 从 **130 ms** 降到 **60 ms**，未使用 JavaScript 从约 **319 KiB** 降到约 **106 KiB**。

主要提升来自减少初始页面加载时需要下载和处理的前端代码量。由于本次优化针对的是资源传输和加载行为，而不是表单语义或导航方式，因此无障碍和最佳实践分数保持稳定。

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
- We declare that we have used GenAI for limited debugging support, code-quality suggestions, testing ideas, accessibility guidance, sustainability analysis, and small refactoring suggestions.

Tool(s) used: ChatGPT  
Parts affected: report drafting and editing, report structure, debugging guidance, testing ideas, accessibility guidance, sustainability interpretation, and limited code-quality suggestions.  
How correctness was ensured: we checked the final report against the coursework brief, verified the report content against our own codebase, and validated implementation details through builds, tests, and manual review before submission.

**中文参考**

关于生成式 AI 使用的声明：

- 我们声明，我们使用了生成式 AI 对报告进行语言润色，并提升表达的清晰度。
- 我们声明，我们还在有限范围内使用了生成式 AI 来获得调试支持、代码质量建议、测试思路、无障碍指导、可持续性分析以及小规模重构建议。

使用工具：ChatGPT  
影响部分：报告撰写与编辑、报告结构、调试指导、测试思路、无障碍指导、可持续性解释，以及有限的代码质量建议。  
正确性保证方式：我们将最终报告与 coursework brief 进行对照检查，依据自己的代码库核对报告内容，并通过构建、测试和人工复查来验证实现细节。
