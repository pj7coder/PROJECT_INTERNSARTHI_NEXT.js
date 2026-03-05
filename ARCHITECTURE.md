# InternSarthi - Industrial Standard Architecture & Project Plan

## 1. Project Overview
**InternSarthi** is an AI-powered platform connecting students and job seekers with internships, jobs, and skill recommendations through a conversational interface (Chatbot UI similar to ChatGPT/Gemini).

## 2. Technology Stack (Industrial Standard Recommendation)

For a modern, scalable, and maintainable application, we recommend the following stack:

### Frontend (Client Side)
- **Framework:** **Next.js 14+ (App Router)** - For server-side rendering, SEO, and performance.
- **Language:** **TypeScript** - For type safety and easier maintenance.
- **Styling:** **Tailwind CSS** - For rapid, consistent styling.
- **UI Library:** **Shadcn/UI** or **Radix UI** - Accessible, unstyled components for maximum customization.
- **State Management:** **Zustand** or **TanStack Query** - meaningful approach to API data fetching.

### Backend (Server Side)
- **Runtime:** **Node.js** (or **Python** if heavy ML processing is custom).
- **Framework:** **NestJS** (Industrial standard for Node.js) or **FastAPI** (Python).
- **Language:** TypeScript (for NestJS) or Python.
- **AI Integration:** **LangChain** or **Vercel AI SDK** - To manage prompts and LLM interactions.

### Database & Storage
- **Primary DB:** **PostgreSQL** (Managed via **Prisma ORM** or **Drizzle**).
- **Vector DB:** **Pinecone** or **pgvector** - For semantic search (matching user queries to job descriptions).
- **Caching:** **Redis** - For session management and caching frequent queries.

### Infrastructure & DevOps
- **Containerization:** **Docker** - Ensuring consistency across dev and prod environments.
- **CI/CD:** **GitHub Actions** - Automated testing and deployment pipelines.
- **Authentication:** **Clerk** or **NextAuth.js** (OAuth + Email).

## 3. Folder Structure (Monorepo Approach)

Using a monorepo (via TurboRepo or standard npm workspaces) keeps frontend and backend code in sync and allows sharing types/utilities.

```
/InternSarthi
├── apps/
│   ├── web/                 # Next.js Frontend
│   │   ├── app/             # App Router pages & Layouts
│   │   ├── components/      # UI Components (ChatInterface, JobCard)
│   │   ├── hooks/           # Custom React hooks
│   │   ├── services/        # Frontend API services
│   │   ├── lib/             # Utility functions (logger, analytics)
│   │   ├── .env.local       # Local Environment Variables
│   │   └── public/          # Static assets
│   │
│   └── api/                 # Backend API (NestJS/FastAPI)
│       ├── src/
│       │   ├── config/      # Env validation (zod/joi) & Config Service
│       │   ├── modules/     # Feature-based modules
│       │   │   ├── jobs/    # Job Board Module
│       │   │   │   └── processors/ # BullMQ Job Processors (Heavy Tasks)
│       │   │   ├── health/  # Health Check Module (/health)
│       │   │   ├── chat/    # Chat Module
│       │   │   │   └── ai/  # AI Controls (Prompts, Fallback Strategy)
│       │   │   └── analytics/# Cost & Token Usage Tracking
│       │   ├── common/      # Guards, Interceptors, Filters, Loggers
│       │   │   ├── logger/  # Winston/Pino Logger Setup
│       │   │   └── guards/  # Throttler/Rate Limiter Guards
│       │   └── main.ts      # Entry point (Swagger & Versioning Setup)
│       ├── test/            # E2E Tests
│       │   └── performance/ # k6 Load Tests scripts
│       └── .env             # Backend Environment Variables
│
├── packages/                # Shared internal libraries
│   ├── ui/                  # Shared UI components (Storybook)
│   ├── db/                  # Database schema & Prisma client
│   ├── types/               # Shared TypeScript interfaces (Zod schemas)
│   ├── logger/              # Shared Logging Interface
│   └── config/              # Shared ESLint/TSConfig
│
├── infra/                   # Infrastructure as Code (IaC)
│   ├── terraform/           # Terraform scripts for AWS/Cloud
│   ├── k8s/                 # Kubernetes Manifests (Helm Charts)
│   └── monitoring/          # Grafana Dashboards & Prometheus Config
│
├── docs/                    # Engineering Governance
│   └── adr/                 # Architecture Decision Records (ADRs)
│
├── .husky/                  # Git Hooks (Pre-commit checks)
├── .github/                 # CI/CD Workflows
│   └── workflows/           # Build & Deploy YAMLs
│
├── docker-compose.yml       # Local development (Postgres, Redis, API, Web)
├── Dockerfile.api           # Production Dockerfile for API
├── Dockerfile.web           # Production Dockerfile for Web
├── README.md                # Documentation & Setup Guide
└── package.json             # Root dependencies (TurboRepo)
```

## 4. Key Features & Workflow

### A. The Chatbot Interface (Core UI)
- **Design:** A clean, central input bar at the bottom.
- **History:** Sidebar showing previous conversation threads.
- **Interactive Responses:** Instead of just text, the bot renders "Job Cards" or "Skill Chips" directly in the chat stream.

### B. The Recommendation Engine
1. **User Profile Ingestion:** User inputs skills/resume via chat.
2. **Embedding:** The system converts this data into vectors.
3. **Matching:** The system searches the vector DB for matching internships/jobs.
4. **Ranking:** Results are re-ranked based on relevance and shown to the user.

## 5. Industrial Standards Checklist (Enterprise Grade)

To move from "Startup-Ready" to **"Enterprise-Ready"**, we implement the following 6 Pillars:

### 1️⃣ Security & Compliance
- **RBAC:** Role-Based Access Control (Admin, Recruiter, Student).
- **Audit Logs:** Track every critical action (e.g., "User X deleted Job Y").
- **Secrets Management:** Use AWS Secrets Manager or Vault (never `.env.production`).
- **Data Protection:** TLS 1.3 (in transit), AES-256 (at rest), and GDPR-style data deletion workflows.

### 2️⃣ Reliability & Disaster Recovery
- **Backups:** Automated daily backups of PostgreSQL (WAL logs for Point-in-Time Recovery).
- **Failover:** Multi-AZ (Availability Zone) database deployment.
- **Circuit Breakers:** Prevent cascading failures when external services (OpenAI) are down.
- **Disaster Recovery:** Documented RTO (Recovery Time Objective) and RPO (Recovery Point Objective) strategies.

### 3️⃣ API Gateway Layer
- **Central Gateway:** Use **Kong** or **Nginx** for SSL termination and routing.
- **Lifecycle:** Proper API versioning (`v1` -> `v2` deprecation policy).
- **Control:** Centralized Rate Limiting and JWT Authentication at the edge.

### 4️⃣ Performance at Scale
- **Edge Caching:** CDN integration (Cloudflare/Vercel Edge) for static assets.
- **Testing:** Load testing with **k6** to simulate 10k concurrent users.
- **Optimization:** Strict query optimization policy (indexing, `EXPLAIN ANALYZE`).

### 5️⃣ Engineering Governance
- **Quality Gates:** Enforce 80% code coverage in CI pipeline.
- **Git Hooks:** Pre-commit hooks (Husky) for linting and **Conventional Commits** standards.
- **ADRs:** Maintain Architecture Decision Records in the repository.

### 6️⃣ AI-Specific Controls (The "InternSarthi" Special)
- **Prompt Versioning:** Track changes to system prompts over time.
- **Model Fallback:** If OpenAI fails, automatically switch to Anthropic/Azure.
- **Cost Control:** Token usage tracking per user and strict budget alerts.
- **Evaluation:** Automated pipeline to evaluate AI response quality (hallucination checks).

## 6. Development Roadmap

### Phase 1: Foundation (Current Step)
- Set up the monorepo structure.
- Configure Linting, Prettier, and TypeScript.
- Set up the Database (PostgreSQL) via Docker.

### Phase 2: Backend Core & Scalability
- **API Setup:** Configure global prefix (`/api/v1`) and Versioning (URI-based).
- **Health Checks:** Implement `/health` endpoint (checks DB & Redis connection).
- **Queues:** Set up **BullMQ** (Redis) for background tasks.
- **Modules:**
    - User Auth (Clerk/JWT).
    - Jobs/Internships (CRUD).
    - Chat (WebSocket/SSE).

### Phase 3: Frontend Interface
- Build the "Chat Layout" (Sidebar + Main Chat Area).
- Integrate Authentication.
- Connect to Backend Chat endpoint.

### Phase 4: Intelligence
- Integrate OpenAI/Gemini API.
- Implement RAG (Retrieval-Augmented Generation) for job matching.

### Phase 5: Production Hardening
- **Observability:** Connect Sentry (Error Tracking) and Prometheus (Metrics).
- **Performance:** Add animations (Framer Motion) and optimize bundles.
- **Deploy:** Push Docker images to Registry and deploy to Cloud (AWS/Vercel).
