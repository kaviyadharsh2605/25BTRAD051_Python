@echo off
setlocal
title SignBridge AI Training
pushd "%~dp0" || exit /b 1
if not exist ".venv\Scripts\python.exe" goto missing_environment
echo Training the model. This replaces model\trained_model.pt.
".venv\Scripts\python.exe" model\train_model.py --epochs 40 --batch_size 32 %*
if errorlevel 1 goto command_failed
echo Evaluating the trained model...
".venv\Scripts\python.exe" model\evaluate_model.py
if errorlevel 1 goto command_failed
echo Training and evaluation complete.
set "result=0"
goto finish
:missing_environment
echo [ERROR] Local Python environment not found. Follow the setup steps in README.md.
set "result=1"
goto finish
:command_failed
set "result=%errorlevel%"
echo [ERROR] Training or evaluation failed. Check the output above.
:finish
popd
exit /b %result%
