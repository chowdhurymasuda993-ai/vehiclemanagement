@echo off
title Push to GitHub - vehiclemanagement
echo ========================================================
echo  Pushing to https://github.com/chowdhurymasuda993-ai/vehiclemanagement
echo ========================================================
set "PATH=%LOCALAPPDATA%\MinGit\cmd;%PATH%"
cd /d "%~dp0"
echo.
git push -u origin main
echo.
if %ERRORLEVEL% EQU 0 (
    echo ========================================================
    echo  SUCCESS! Pushed to https://github.com/chowdhurymasuda993-ai/vehiclemanagement
    echo ========================================================
) else (
    echo ========================================================
    echo  If prompted, sign in via browser or paste your GitHub
    echo  Personal Access Token (PAT).
    echo ========================================================
)
pause
