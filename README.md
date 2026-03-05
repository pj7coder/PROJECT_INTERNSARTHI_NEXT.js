# InternSarthi - AI-Powered Internship Platform

A modern, full-stack job portal connecting students with recruiters, enhanced by **Gemini AI**.

## 🚀 Features

-   **Role-Based Access**: Specialized dashboards for Students (Job Feed) and Recruiters (Job Management).
-   **AI Career Assistant**: **Sarthi AI** (Gemini) provides real-time career guidance and resume tips.
-   **Job Management**: Create, Edit, and Delete internship postings.
-   **Application Flow**: easy application process with **File Uploads** (Resume) and Cover Letters.
-   **Notifications**: Automated email alerts for recruiters upon new applications.
-   **Profile System**: Build your professional identity with Skills, Bio, and Social Links.

## 🛠 Tech Stack

-   **Frontend**: Next.js 14 (App Router), Tailwind CSS, shadcn/ui, Lucide Icons.
-   **Backend**: NestJS, Prisma ORM, PostgreSQL (Supabase).
-   **AI**: Google Generative AI (Gemini Pro).
-   **Storage**: Local File Storage (Multer) - production ready for S3 migration.
-   **Communication**: Resend Email API.

## 🏁 Getting Started

### Prerequisites
-   Node.js 18+
-   PostgreSQL Database URL (e.g., Supabase Transaction Pooler).

### Installation

1.  **Install Dependencies** (from root):
    ```bash
    npm install
    ```

2.  **Configure Backend**:
    -   Create `apps/api/.env`:
        ```env
        DATABASE_URL="postgresql://user:pass@host:6543/postgres?pgbouncer=true"
        JWT_SECRET="your-secret-key"
        GEMINI_API_KEY="your-gemini-key"
        RESEND_API_KEY="your-resend-key" (Optional)
        PORT=3001
        ```

3.  **Configure Frontend**:
    -   Create `apps/web/.env.local`:
        ```env
        NEXT_PUBLIC_API_URL="http://localhost:3001/api/v1"
        ```

### Running Locally (Windows)

1.  **Start Backend** (Database Push + Seed + Server):
    ```powershell
    .\apps\api\start-backend.bat
    ```
    *Wait for "Application is running on: http://localhost:3001/api/v1"*

2.  **Start Frontend**:
    Open a new terminal:
    ```powershell
    cd apps/web
    npm run dev
    ```

3.  **Access App**:
    Open [http://localhost:3000](http://localhost:3000).

## 🧪 Testing

-   **Student Account**: Register/Login as Student.
-   **Recruiter Account**: Register/Login as Recruiter.
-   **Uploads**: Test resume upload in Profile or Application Apply dialog.
-   **AI Chat**: Click the floating bot icon on Student Dashboard.

## License
MIT
