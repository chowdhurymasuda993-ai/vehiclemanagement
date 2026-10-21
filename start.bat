@echo off
title Local Web Server - Vehicle Management Portal
echo Starting local web server at http://localhost:8080/ ...
start http://localhost:8080/
powershell -ExecutionPolicy Bypass -File "%~dp0server.ps1" -Port 8080
pause
