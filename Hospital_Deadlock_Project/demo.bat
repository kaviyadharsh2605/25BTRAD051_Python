@echo off
title Hospital Deadlock Project Demo - 25BTRAD051
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0demo.ps1"
set "result=%errorlevel%"
if not "%result%"=="0" pause
exit /b %result%
