# Implemented Site Structure

This file provides an updated site structure diagram based on the **actual implemented frontend routes and pages**, while keeping the same layered style as your original site map.

## Mermaid Site Structure Diagram

```mermaid
flowchart TB
    subgraph L1["Level 1 (Public)"]
        LP["Landing Page"]
    end

    subgraph L2["Level 2 (Authentication)"]
        AUTH["Login / Register<br/>(Role-based redirection)<br/>(Supports M1)"]
    end

    subgraph L3["Level 3 (Main Hub)"]
        SD["Home<br/>(Student Dashboard)"]
        AD["Home<br/>(Admin Dashboard)<br/>(Supports S2)"]
    end

    subgraph L4["Level 4 (Feature)"]
        BR["Browse Rooms<br/>(Supports M2)"]
        MB["My Bookings"]
        BH["Booking History<br/>(Supports M4)"]
        SP["Profile / Security<br/>(Account Settings)"]

        RM["Room Management<br/>(Supports M5)"]
        BM["Building Management"]
        EM["Equipment Management"]
        BQ["Booking Requests<br/>(Supports M6)"]
        UM["User Management"]
        AP["Profile / Security<br/>(Admin Settings)"]
    end

    subgraph L5["Level 5 (Actions)"]
        RD["Room Detail / Booking Request<br/>(Supports M3)"]
        SA["Availability Check / Review Display"]
        CB["Cancel Booking<br/>(Supports S1)"]
        LR["Leave Review<br/>(Supports C1)"]
        CPS["Change Password"]

        AR["Add / Edit / Delete Room"]
        AB["Add / Edit / Delete Building"]
        AE["Add / Edit / Delete Equipment"]
        APR["Approve / Reject Request"]
        AU["Add / Edit / Delete User"]
        CPA["Change Password"]
    end

    LP --> AUTH

    AUTH -->|Student| SD
    AUTH -->|Admin| AD

    SD --> BR
    SD --> MB
    SD --> BH
    SD --> SP

    AD --> RM
    AD --> BM
    AD --> EM
    AD --> BQ
    AD --> UM
    AD --> AP

    BR --> RD
    RD --> SA
    MB --> CB
    BH --> LR
    SP --> CPS

    RM --> AR
    BM --> AB
    EM --> AE
    BQ --> APR
    UM --> AU
    AP --> CPA
```

## Main Differences from the Original Site Structure

1. The implemented system separates **My Bookings** and **Booking History** into two different pages rather than combining them into one feature branch.

2. The student room journey is more detailed in the final implementation:
   - `Browse Rooms`
   - `Room Detail`
   - `Booking Request`
   - `Availability Check`
   - room reviews visible on the detail page

3. The administrator side is more complete than the original design because it now includes:
   - `Building Management`
   - `Equipment Management`
   - `User Management`
   - admin profile / security settings

4. Both student and administrator roles now have a **Profile / Security** page, which was not fully represented in the original site map.

5. The implemented system keeps `Login` and `Register` as separate routes, but they are grouped together in this diagram to preserve the original visual style.

## Suggested Figure Caption

**Figure X. Updated site structure of the implemented Study Room Booking System.**

## Suggested Report Paragraph

The implemented site structure follows a role-based navigation model. Public users can access the landing page and authentication pages, after which the system redirects users to either the student or administrator dashboard according to their role. On the student side, the main features include room browsing, room detail and booking request pages, my bookings, booking history, and profile settings. On the administrator side, the implemented structure is broader than the original design and includes room management, building management, equipment management, booking request handling, user management, and profile settings. This updated site map reflects the actual implemented routes and user flows more accurately than the original design version.
