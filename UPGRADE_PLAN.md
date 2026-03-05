# InternSarthi - Comprehensive Upgrade Plan

## 🔍 Analysis Summary

After analyzing the entire monorepo (apps/api, apps/web, packages/db, packages/ui, packages/types, packages/config, packages/logger, infra, Docker, CI/CD) — here are all the issues found and upgrades recommended.

---

## 🚨 CRITICAL Issues (Must Fix)

### 1. **Security: Database credentials exposed in `.env.local` (COMMITTED TO GIT)**
- **File**: `.env.local` (root)
- **Issue**: Real Supabase `DATABASE_URL` with password & `JWT_SECRET` are committed. `.gitignore` lists `.env.local` but the file exists — it may have been force-added.
- **Fix**: Rotate credentials immediately, add `.env.example` template.

### 2. **Auth Controller: Throwing generic `Error` instead of NestJS exceptions**
- **File**: `apps/api/src/modules/auth/auth.controller.ts:18`
- **Issue**: `throw new Error('Invalid credentials')` — This returns HTTP 500 instead of 401.
- **Fix**: Use `UnauthorizedException` from NestJS.

### 3. **Auth Controller: No DTO validation on login/register**
- **File**: `apps/api/src/modules/auth/auth.controller.ts`
- **Issue**: `@Body() req: any` — raw `any` types bypass the global `ValidationPipe`.
- **Fix**: Create `LoginDto` and `RegisterDto` with `class-validator` decorators.

### 4. **Database Mismatch: Schema uses `sqlite` but env points to PostgreSQL**
- **File**: `packages/db/prisma/schema.prisma:9` → `provider = "sqlite"`
- **File**: `.env.local` → `DATABASE_URL="postgresql://...supabase.co..."`
- **Issue**: The Prisma schema is configured for SQLite, but the env var points to a PostgreSQL Supabase instance. This causes runtime errors.
- **Fix**: Migrate to PostgreSQL provider (matching the architecture plan).

### 5. **Chat Interface: Simulated responses instead of real API calls**
- **File**: `apps/web/components/chat/chat-interface.tsx:59-68`
- **Issue**: The main chat interface uses `setTimeout()` with mock responses instead of calling the actual backend `/chat/send` endpoint.
- **Fix**: Connect to the real API endpoint.

---

## ⚠️ HIGH Priority Upgrades

### 6. **Empty shared packages (dead code)**
- `packages/types/` — Empty directory
- `packages/config/` — Empty directory
- `packages/logger/` — Empty directory
- **Fix**: Populate with actual shared types, ESLint configs, and logger setup OR remove references.

### 7. **Duplicated type definitions**
- `apps/api/src/common/types.ts` defines `Role`, `JobType`, `MessageRole`, `ApplicationStatus`
- `apps/api/src/modules/users/users.service.ts:4` redefines `Role` locally
- `apps/api/src/modules/chat/chat.service.ts:5` redefines `MessageRole` locally
- **Fix**: Centralize into `packages/types/` and import everywhere.

### 8. **Missing `DATABASE_URL` in Prisma env validation**
- **File**: `apps/api/src/app.module.ts:26-31`
- **Issue**: `ConfigModule` validates `JWT_SECRET` and `PORT`, but not `DATABASE_URL` which is required for Prisma.
- **Fix**: Add `DATABASE_URL: Joi.string().required()`.

### 9. **Next.js config: wrong package name for transpile**
- **File**: `apps/web/next.config.mjs:3`
- **Issue**: `transpilePackages: ["ui"]` should be `"@internsarthi/ui"`.
- **Fix**: Match the actual package name.

### 10. **Docker Compose: deprecated `version` field**
- **File**: `docker-compose.yml:1`
- **Issue**: `version: '3.8'` is deprecated in modern Docker Compose.
- **Fix**: Remove the `version` field.

### 11. **Unused Navbar component (imported but never rendered)**
- **File**: `apps/web/app/layout.tsx:4` imports `Navbar` but never uses it.
- **Fix**: Remove unused import or add Navbar to appropriate layouts.

### 12. **JWT expiry too short (60 minutes)**
- **File**: `apps/api/src/modules/auth/auth.module.ts:18`
- **Issue**: `expiresIn: '60m'` — no refresh token mechanism exists.
- **Fix**: Either extend to 7 days or implement refresh tokens.

---

## 🔧 MEDIUM Priority Upgrades

### 13. **No global error handling (Exception Filter)**
- **Fix**: Add a global `HttpExceptionFilter` for consistent error responses.

### 14. **No request logging middleware**
- `packages/logger/` exists but is empty.
- **Fix**: Add Winston/Pino logger with request/response logging middleware.

### 15. **Missing `@nestjs/config` env validation for all env vars**
- `ADZUNA_API_KEY`, `RESEND_API_KEY`, `DATABASE_URL` are not validated.

### 16. **Chat Widget response doesn't match API contract**
- `chat-widget.tsx:60` expects `data.response` and `data.sessionId`
- Backend `ChatController` returns the `Message` object with `content`, `sessionId` is part of the message model.
- **Fix**: Align frontend expectations with backend response format.

### 17. **No ESLint/Prettier config in root (only in api)**
- `packages/config/` should contain shared ESLint + Prettier configs.

### 18. **Prisma schema: commented-out array fields**
- Skills arrays removed due to SQLite limitations — switching to PostgreSQL resolves this.

### 19. **Profile page references fields not in database schema**
- `linkedinUrl`, `githubUrl`, `portfolioUrl` don't exist in the Prisma schema.

### 20. **Husky hooks not configured**
- `.husky/` directory exists but no hooks are set up inside.

---

## 💄 LOW Priority (Polish)

### 21. **Dashboard uses `Link` from lucide-react instead of next/link**
- `apps/web/app/dashboard/page.tsx:15` — `import { Link } from "lucide-react"` is wrong.

### 22. **No favicon or Open Graph images**
- SEO metadata is minimal.

### 23. **Missing loading states on Jobs page**
- Jobs page shows mock data immediately even before API finishes.

### 24. **No dark mode toggle**
- Dark mode CSS variables exist but no UI toggle.

### 25. **`Dockerfile.web` is empty**
- File exists at root but has no content.

---

## 📦 Implementation Order

1. Fix security (rotate creds, `.env.example`)
2. Fix database schema (SQLite → PostgreSQL)
3. Fix auth controller (DTOs, proper exceptions)
4. Connect chat UI to real backend API
5. Fix Next.js config
6. Populate shared packages (types, config, logger)
7. Fix Docker Compose
8. Add global error filter
9. Fix API response contract mismatches
10. Polish & remaining fixes
