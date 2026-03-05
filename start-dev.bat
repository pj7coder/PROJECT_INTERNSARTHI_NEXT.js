@echo off
echo ==========================================
echo   InternSarthi Development Starter
echo ==========================================
echo.

:: Check Node.js
echo [1/5] Checking Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js is not installed. Please install Node.js 18+ from https://nodejs.org
    pause
    exit /b 1
)

:: Check for .env.local
echo [2/5] Checking environment files...
if not exist ".env.local" (
    echo WARNING: .env.local not found! Copying from .env.example...
    if exist ".env.example" (
        copy ".env.example" ".env.local"
        echo IMPORTANT: Please edit .env.local with your actual credentials before continuing!
        notepad .env.local
        pause
    ) else (
        echo ERROR: No .env.example found either. Please create a .env.local file.
        pause
        exit /b 1
    )
)

:: Install dependencies
echo [3/5] Installing dependencies...
call npm install --legacy-peer-deps

:: Generate Prisma Client
echo [4/5] Generating Prisma Client...
cd packages\db
call npx prisma generate
cd ..\..

:: Start dev servers
echo [5/5] Starting Application (API + Web)...
echo.
echo   Frontend:  http://localhost:3000
echo   Backend:   http://localhost:3001
echo   API Docs:  http://localhost:3001/api/docs
echo.
echo Press Ctrl+C to stop all servers.
npm run dev
