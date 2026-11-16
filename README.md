# Hospital Deadlock Simulation and Python Coursework

**Kaviya Dharshini · 25BTRAD051**

The experiential-learning project implements the Java hospital resource-allocation simulation described in the supplied Operating Systems report. It calculates the Need matrix and uses Banker's safety algorithm to display a safe execution sequence or an unsafe-state result.

| Folder | Contents |
| --- | --- |
| [Experiential Learning Activity](25BTRAD051_EXPERIENTIAL%20LEARNING%20ACTIVITY/README.md) | Hospital deadlock simulation, Java source, Windows launchers, sample inputs and outputs, regression checks, and source report |
| [Lab Exercises](25BTRAD051_Lab%20Exercises/) | Existing Python laboratory exercises and output images |
| [Problem Solving](25BTRAD051_Problem%20Solving/) | Existing Python assignments, attendance tracker, OTP generator, and unit converter |

## Run the hospital project on Windows

Install a JDK version 11 or newer. From the repository root, run:

```powershell
Set-Location '.\25BTRAD051_EXPERIENTIAL LEARNING ACTIVITY'
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run.ps1 -InputFile .\samples\safe.txt -Trace
```

Expected result: `SAFE`, with `P1 -> P3 -> P4 -> P0 -> P2`.

Run `start.bat` for interactive input. See the [project guide](25BTRAD051_EXPERIENTIAL%20LEARNING%20ACTIVITY/README.md) for input format, compilation on Linux, sample results, and tests.

The hospital project checks a fixed snapshot for teaching purposes. It does not manage live hospital services or clinical equipment. An unsafe state does not, by itself, establish that deadlock has already occurred.
