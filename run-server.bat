@echo off
echo ===============================================
echo    Employee Management System
echo    ASP.NET Web Forms Application
echo ===============================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed or not in PATH
    echo Please install Python from https://python.org
    pause
    exit /b 1
)

echo Starting HTTP Server on port 3000...
echo.
echo Open your browser and navigate to:
echo http://localhost:3000/Login.aspx
echo.
echo Demo Credentials:
echo ==================
echo HR Admin: hr_admin / hr123
echo IT Admin: it_admin / it123
echo Finance Admin: finance_admin / finance123
echo Marketing Admin: marketing_admin / marketing123
echo.
echo Press Ctrl+C to stop the server
echo.

python -m http.server 3000