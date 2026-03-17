# Actual High-Level System Architecture Diagram

Below is a **report-ready simplified diagram** that matches your earlier drawing style more closely.

Important distinction:

- `Client-side Frontend` means the React SPA running in the browser
- `Frontend Static Hosting Container` means the deployed server-side container that serves the built frontend files

For your report, the first diagram below is the recommended one.

## Report-Ready Simplified Diagram

```mermaid
flowchart LR
    U["Browser / Mobile Browser<br/>HTML / CSS / JS"]
    C["Client-side Frontend<br/>React SPA running in browser"]

    subgraph Edge["Public Edge"]
        N["Nginx Load Balancer / Reverse Proxy"]
    end

    subgraph Middleware["Middleware / Application Tier"]
        F["Frontend Static Hosting Container<br/>Built React + Vite files"]

        subgraph BP["Application Server Pool"]
            B1["Django REST API<br/>backend-app-1"]
            B2["Django REST API<br/>backend-app-2"]
        end

        J["Java gRPC Service<br/>Room Recommendation"]
        G["Go gRPC Service<br/>Availability Search"]
    end

    subgraph DB["Database Read-Write Separation"]
        P["PostgreSQL Primary<br/>Write Database"]
        R1["PostgreSQL Replica 1<br/>Read Database"]
        R2["PostgreSQL Replica 2<br/>Read Database"]
    end

    subgraph Cache["Cluster Mode"]
        RC["Redis Cluster<br/>6 Nodes"]
    end

    U -->|"Load SPA assets"| C
    C -->|"HTTP/HTTPS requests"| N
    N -->|"Serve frontend files"| F
    N -->|"Proxy /api/* and /manage/*"| B1
    N -->|"Proxy /api/* and /manage/*"| B2

    B1 -->|"gRPC"| J
    B2 -->|"gRPC"| J
    B1 -->|"gRPC"| G
    B2 -->|"gRPC"| G

    B1 -->|"Write queries / ORM"| P
    B2 -->|"Write queries / ORM"| P
    B1 -->|"Read queries via router"| R1
    B1 -->|"Read queries via router"| R2
    B2 -->|"Read queries via router"| R1
    B2 -->|"Read queries via router"| R2

    P -. "Replication" .-> R1
    P -. "Replication" .-> R2

    B1 -->|"Cache / lock access"| RC
    B2 -->|"Cache / lock access"| RC
```

## Why this is the recommended version

This version lets you show the frontend near the client side, which matches your earlier diagram style, but it avoids a deployment error by:

- using `Client-side Frontend` for the browser runtime
- keeping the real deployed `Frontend Static Hosting Container` inside the server-side application tier

So the diagram stays both:

- visually similar to your original design diagram
- technically accurate for the implemented project

## Suggested Figure Caption

**Figure X. High-level system architecture of the implemented Study Room Booking System.**

## Suggested Paragraph for the Report

The implemented Study Room Booking System uses a multi-service web architecture. Users access the system through a browser, where a React single-page application runs on the client side after the frontend assets are loaded. All external traffic is routed through an Nginx reverse proxy, which serves the frontend files and forwards API and admin requests to a pool of Django backend containers. The Django backend handles authentication, business logic, and database interaction, and also communicates with two internal gRPC services: a Java service for room recommendation and a Go service for availability search. For persistence, the system uses a PostgreSQL primary database with two read replicas, while Redis Cluster is used for caching and distributed locking. This diagram reflects the actual implemented architecture of the project.

## More Deployment-Focused Version

If you later want a more deployment-oriented diagram, you can still use this version:

```mermaid
flowchart LR
    U["Browser / Mobile Browser"]

    subgraph Edge["Public Edge"]
        N["Nginx Load Balancer / Reverse Proxy<br/>Single Public Entry Point"]
    end

    subgraph App["Application / Service Tier"]
        F["Frontend Static Hosting Container"]

        subgraph BP["Django Backend Pool"]
            B1["backend-app-1<br/>Django REST API"]
            B2["backend-app-2<br/>Django REST API"]
        end

        J["Java gRPC Service"]
        G["Go gRPC Service"]
    end

    subgraph Data["Data / Cache Tier"]
        P["PostgreSQL Primary"]
        R1["PostgreSQL Replica 1"]
        R2["PostgreSQL Replica 2"]
        RC["Redis Cluster"]
    end

    U --> N
    N --> F
    N --> B1
    N --> B2
    B1 --> J
    B2 --> J
    B1 --> G
    B2 --> G
    B1 --> P
    B2 --> P
    B1 --> R1
    B1 --> R2
    B2 --> R1
    B2 --> R2
    P -.-> R1
    P -.-> R2
    B1 --> RC
    B2 --> RC
```
