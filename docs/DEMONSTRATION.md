# Demonstrating the Hospital Deadlock Project

**Kaviya Dharshini · 25BTRAD051 · Operating Systems**

Run these commands from the repository root on Windows with JDK 11 or newer installed.

## 1. Run the report example

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run.ps1 -InputFile .\samples\safe.txt -Trace
```

The five processes share three resource types: database connections, storage slots, and printers. Available starts as `[3, 3, 2]`.

Expected Need matrix:

```text
P0: 7 4 3
P1: 1 2 2
P2: 6 0 0
P3: 0 1 1
P4: 4 3 1
```

Expected result:

```text
System is in a SAFE state.
Safe sequence: P1 -> P3 -> P4 -> P0 -> P2
```

P1 completes first because `[1, 2, 2] <= [3, 3, 2]` in every component. It releases `[2, 0, 0]`, increasing Work to `[5, 3, 2]`. P3 and P4 then qualify. The next scan completes P0 and P2.

The complete captured run is in [safe-output.txt](../samples/safe-output.txt).

## 2. Show an unsafe snapshot

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run.ps1 -InputFile .\samples\unsafe.txt -Trace
```

P0 holds A and needs B; P1 holds B and needs A. Available is `[0, 0]`, so neither qualifies for simulated completion.

Expected status: `System is in an UNSAFE state.` The trace lists `Unfinished processes: P0 P1`.

Describe this as an unsafe snapshot. The input provides maximum demands rather than current outstanding requests, so the program does not claim to have detected a live deadlock. See [unsafe-output.txt](../samples/unsafe-output.txt).

## 3. Show input validation

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run.ps1 -InputFile .\samples\invalid-negative.txt
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run.ps1 -InputFile .\samples\invalid-maximum.txt
```

The first input is rejected because Allocation is negative; the second because Maximum is below Allocation. Both return exit code 1. A valid safe or unsafe analysis returns 0.

## 4. Run the checks

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\test.ps1
```

Expected: `22/22 checks passed.` Checks cover the report example, resource release, component-by-component eligibility, large Work totals, invalid and incomplete input, missing files, standard input, and command options.

## 5. Enter a snapshot interactively

Double-click `start.bat`, or run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run.ps1
```

Enter the values from [safe.txt](../samples/safe.txt): process count, resource count, Allocation, Maximum, and Available. The result appears when the vector is complete.

## Presentation scope

The program calculates Need and checks one fixed snapshot. Maximum demands must be known beforehand. Live requests, resource graphs, recovery, storage of results, and a graphical interface are future enhancements in the report.

[Back to the project guide](../README.md)
