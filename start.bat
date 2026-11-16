@echo off
title Hospital Deadlock Simulation - 25BTRAD051
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0run.ps1" %*
set "result=%errorlevel%"
if "%~1"=="" pause
exit /b %result%
