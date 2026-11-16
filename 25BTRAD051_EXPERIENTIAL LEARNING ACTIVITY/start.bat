@echo off
setlocal
title SignBridge AI Server
pushd "%~dp0" || exit /b 1
if not exist ".venv\Scripts\python.exe" goto missing_environment
if not exist "model\trained_model.pt" goto missing_model
echo Starting SignBridge AI at http://localhost:8000
echo Press Ctrl+C to stop the server.
".venv\Scripts\python.exe" -m uvicorn backend.main:app --host 127.0.0.1 --port 8000
set "result=%errorlevel%"
goto finish
:missing_environment
echo [ERROR] Local Python environment not found. Follow the setup steps in README.md.
set "result=1"
goto finish
:missing_model
echo [ERROR] model\trained_model.pt is missing. Restore the saved model or run train.bat.
set "result=1"
:finish
popd
exit /b %result%
