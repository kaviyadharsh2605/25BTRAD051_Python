# Python Coursework and SignBridge AI

**Kaviya Dharshini · 25BTRAD051**

This repository contains Python lab exercises, problem-solving assignments, and **SignBridge AI**, a webcam-based sign-language recognition demonstration. SignBridge combines hand landmarks, a PyTorch LSTM model, and geometric gesture rules to produce text and speech.

## Repository guide

| Folder | Contents |
| --- | --- |
| [Experiential Learning Activity](25BTRAD051_EXPERIENTIAL%20LEARNING%20ACTIVITY/README.md) | SignBridge AI application, saved models, training scripts, and dataset archives |
| [Lab Exercises](25BTRAD051_Lab%20Exercises/README.md) | 17 Python exercise folders with source code and output images |
| [Problem Solving](25BTRAD051_Problem%20Solving/README.md) | Unit 1 assignments, attendance tracker, OTP generator, and unit converter |

## Start SignBridge AI on Windows

Use 64-bit Python 3.11 or 3.12 and PowerShell. Python must be installed and available as `python`. If Windows opens the Microsoft Store, install Python and reopen the terminal first.

```powershell
git clone https://github.com/kaviyadharsh2605/25BTRAD051_Python.git
Set-Location '.\25BTRAD051_Python\25BTRAD051_EXPERIENTIAL LEARNING ACTIVITY'
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install --upgrade pip
.\.venv\Scripts\python.exe -m pip install torch --index-url https://download.pytorch.org/whl/cpu
.\.venv\Scripts\python.exe -m pip install -r .\backend\requirements.txt
.\start.bat
```

Open [localhost:8000](http://localhost:8000), allow camera access, and start the camera from the page. The saved model is included; dataset extraction and retraining are optional. Installation and the browser's MediaPipe CDN assets require internet access.

See the [application guide](25BTRAD051_EXPERIENTIAL%20LEARNING%20ACTIVITY/README.md) for training, evaluation, and troubleshooting.

## Run the coursework

The lab and problem-solving scripts use Python's standard library. Open an exercise folder and run:

```powershell
python .\main.py
```

The combined Unit 1 assignment has a menu-driven script described in the [problem-solving guide](25BTRAD051_Problem%20Solving/README.md). Interactive programs prompt for values. Output images are saved examples; results may differ for other inputs or random values.

## Scope and repository hygiene

SignBridge is an educational demonstration with 20 labels, including the idle label NEUTRAL. It does not translate arbitrary sign-language sentences. Training tools can generate synthetic landmarks; synthetic-data scores do not establish real-world recognition accuracy.

Saved models, dataset archives, coursework, and output images are retained. `.gitignore` excludes virtual environments, caches, and extracted datasets. The application uses paths relative to its own folder.
