param(
    [ValidateSet('Menu', 'Safe', 'Unsafe', 'Validation', 'Interactive', 'Tests')]
    [string]$Scenario = 'Menu'
)
$ErrorActionPreference = 'Stop'

function Invoke-DemoScenario([string]$SelectedScenario) {
    $runner = Join-Path $PSScriptRoot 'run.ps1'
    switch ($SelectedScenario) {
        'Safe' {
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $runner -InputFile (Join-Path $PSScriptRoot 'samples\safe.txt') -Trace
            if ($LASTEXITCODE -ne 0) { throw 'The safe demonstration failed.' }
        }
        'Unsafe' {
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $runner -InputFile (Join-Path $PSScriptRoot 'samples\unsafe.txt') -Trace
            if ($LASTEXITCODE -ne 0) { throw 'The unsafe demonstration failed.' }
        }
        'Validation' {
            foreach ($sample in @('invalid-negative.txt', 'invalid-maximum.txt')) {
                Write-Host "`nValidation example: $sample"
                & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $runner -InputFile (Join-Path $PSScriptRoot "samples\$sample")
                if ($LASTEXITCODE -ne 1) { throw "Expected input rejection for $sample." }
            }
        }
        'Interactive' {
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $runner
            if ($LASTEXITCODE -ne 0) { throw 'The interactive run ended with an input error.' }
        }
        'Tests' {
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'test.ps1')
            if ($LASTEXITCODE -ne 0) { throw 'Regression checks failed.' }
        }
    }
}

if ($Scenario -ne 'Menu') {
    Invoke-DemoScenario $Scenario
    exit 0
}

while ($true) {
    Write-Host "`nHOSPITAL DEADLOCK PROJECT - DEMONSTRATION"
    Write-Host '1. Safe example with resource-release trace'
    Write-Host '2. Unsafe example with unfinished processes'
    Write-Host '3. Input validation examples'
    Write-Host '4. Enter your own snapshot'
    Write-Host '5. Run all regression checks'
    Write-Host '0. Exit'
    $selection = Read-Host 'Choose an option'
    if ($selection -eq '0') { exit 0 }
    $scenarios = @{ '1' = 'Safe'; '2' = 'Unsafe'; '3' = 'Validation'; '4' = 'Interactive'; '5' = 'Tests' }
    if (-not $scenarios.ContainsKey($selection)) {
        Write-Host 'Enter a number from 0 to 5.'
        continue
    }
    try { Invoke-DemoScenario $scenarios[$selection] }
    catch { Write-Host "Unable to complete the demonstration: $($_.Exception.Message)" -ForegroundColor Red }
    Read-Host 'Press Enter to return to the menu' | Out-Null
}
