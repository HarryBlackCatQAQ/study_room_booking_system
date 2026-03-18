# Implemented Site Structure

This file provides an updated site structure diagram based on the actual frontend routes and key page-level actions, while keeping the same layered style as the original site map.

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
        BR["Browse Rooms / Smart Suggestions<br/>(Supports M2)"]
        MB["My Bookings<br/>(Supports M4)"]
        BH["Booking History<br/>(Supports M4)"]
        SP["Profile / Security"]

        RM["Room Management<br/>(Supports M5)"]
        BM["Building Management"]
        EM["Equipment Management"]
        BQ["Booking Requests<br/>(Supports M6)"]
        UM["User Management"]
        AP["Profile / Security"]
    end

    subgraph L5["Level 5 (Actions)"]
        RD["Room Detail / Booking Request<br/>(Supports M3)"]
        AV["Availability Check / Review Display"]
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
    RD --> AV
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

## Notes for Figure 3

1. `Login` and `Register` remain separate routes in the code, but they are grouped together here to preserve the original layered visual style.
2. The student journey is more detailed than the original design because room browsing is followed by a room detail page, booking request flow, availability checking, and review display.
3. The implemented system separates `My Bookings` and `Booking History` into two different pages instead of combining them into one branch.
4. The administrator structure is broader than the original design because it now includes dedicated pages for buildings, equipment, users, and profile/security.

## Suggested Figure Caption

**Figure 3. Updated site structure of the implemented Study Room Booking System.**
