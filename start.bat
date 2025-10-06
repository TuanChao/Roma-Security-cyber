@echo off
REM Start script for Security Monitoring Agent System (Windows)

echo ========================================
echo Security Monitoring Agent System
echo Docker Setup for Windows
echo ========================================
echo.

REM Check if Docker is running
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed or not running!
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker Compose is not installed!
    pause
    exit /b 1
)

echo [OK] Docker is installed
echo [OK] Docker Compose is installed
echo.

REM Check if .env exists
if not exist .env (
    echo Creating .env file from template...
    copy .env.docker .env
    echo.
    echo [IMPORTANT] Please edit .env and add your OPENAI_API_KEY
    echo.
    pause
)

REM Build images
echo Building Docker images...
docker-compose build

echo.
echo Starting services...
docker-compose up -d

echo.
echo Waiting for services to start...
timeout /t 5 /nobreak >nul

REM Check if services are running
docker-compose ps
echo.

echo ========================================
echo Services are running!
echo ========================================
echo.
echo Access points:
echo   - Frontend Dashboard: http://localhost:3000
echo   - Backend API:        http://localhost:8000
echo   - API Documentation:  http://localhost:8000/docs
echo.
echo Useful commands:
echo   - View logs:    docker-compose logs -f
echo   - Stop all:     docker-compose down
echo   - Restart:      docker-compose restart
echo.

pause
