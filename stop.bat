@echo off
REM Stop script for Security Monitoring Agent System (Windows)

echo ========================================
echo Stopping Security Monitoring System
echo ========================================
echo.

docker-compose down

echo.
echo [OK] All services stopped
echo.

pause
