@echo off
setlocal
cd /d "%~dp0"
where py >nul 2>nul
if %errorlevel%==0 (
  echo Starting Roblox Profile Website on http://localhost:8080
  start "Roblox Profile" cmd /k "py -m http.server 8080"
) else (
  where python >nul 2>nul
  if %errorlevel%==0 (
    echo Starting Roblox Profile Website on http://localhost:8080
    start "Roblox Profile" cmd /k "python -m http.server 8080"
  ) else (
    echo Python tidak ditemukan.
    echo Install Python 3 lalu jalankan file ini lagi.
    pause
    exit /b 1
  )
)
timeout /t 2 /nobreak >nul
start "" "http://localhost:8080/index.html"
endlocal
