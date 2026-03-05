# Industrial Project Requirements

To transform **InternSarthi** into a production-grade, industrial application, we need to integrate external services for storage, intelligence, and communication.

## 🚨 Immediate Priorities (Blockers)
These are required **now** to run the core features we have built.

### 1. Database (PostgreSQL)
Since local Docker is failing, I highly recommend using a **Managed Cloud Database**. This is more stable and "production-like".
- **Provider**: [Neon.tech](https://neon.tech) (Free tier is excellent) or [Supabase](https://supabase.com).
- **Needed**: `DATABASE_URL` (Connection string).
- **Why**: Bypasses your local Docker issues and allows access from anywhere.

### 2. AI Intelligence (Gemini/Groq)
Required for the "Sarthi" Chatbot and Resume Analysis.
- **Provider**: Google AI Studio or Groq.
- **Needed**: `GEMINI_API_KEY` or `GROQ_API_KEY`.

### 3. Job Data (Adzuna)
Required to seed the platform with real-world job listings.
- **Provider**: [Adzuna API](https://developer.adzuna.com/).
- **Needed**: `ADZUNA_APP_ID` and `ADZUNA_APP_KEY`.

---

## 🚀 Industrial Enhancements (Recommended)
These will make the application "enterprise-ready".

### 4. File Storage (Resumes/Avatars)
We cannot store user uploads (PDFs, Images) in the database or local disk in production.
- **Provider**: [Cloudinary](https://cloudinary.com/) (Easiest) or AWS S3.
- **Needed**: `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, `CLOUDINARY_API_SECRET`.

### 5. Email & Notifications
To send "Verify Email", "Application Received", or "Job Alert" emails.
- **Provider**: [Resend](https://resend.com) (Modern, developer-friendly).
- **Needed**: `RESEND_API_KEY`.

### 6. Authentication (Social Login)
Enterprise apps typically support "Login with Google/GitHub".
- **Provider**: Google Cloud Console / GitHub Developer Settings.
- **Needed**: `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`.

### 7. Observability (Monitoring)
To track errors and performance in production.
- **Provider**: [Sentry](https://sentry.io/welcome/).
- **Needed**: `SENTRY_DSN`.

---

## Action Plan
1. **Provide the Immediate Keys**: Update `apps/api/.env` with Database URL, Gemini, and Adzuna keys.
2. **Decide on Storage**: If you want file uploads (Resumes), sign up for Cloudinary (free tier).
