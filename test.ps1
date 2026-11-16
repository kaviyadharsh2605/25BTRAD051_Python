$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'scripts\Get-JavaTools.ps1')
$javaTools = Get-JavaTools
$buildPath = Join-Path $PSScriptRoot 'build'
New-Item -ItemType Directory -Path $buildPath -Force | Out-Null
& $javaTools.Javac --release 11 -d $buildPath (Join-Path $PSScriptRoot 'HospitalDeadlock.java')
if ($LASTEXITCODE -ne 0) { throw 'Compilation failed.' }

$testCases = @(
    @{ Name = 'Report sample and full release trace'; File = 'safe.txt'; Code = 0; Trace = $true; Match = @('System is in a SAFE state\.', 'Safe sequence: P1 -> P3 -> P4 -> P0 -> P2', 'P0: 7 4 3', 'P1: 1 2 2', 'P2: 6 0 0', 'P3: 0 1 1', 'P4: 4 3 1', 'Work \[10, 5, 7\]'); Absent = 'UNSAFE' },
    @{ Name = 'Circular-wait snapshot'; File = 'unsafe.txt'; Code = 0; Trace = $true; Match = @('System is in an UNSAFE state\.', 'Unfinished processes: P0 P1', 'does not necessarily mean deadlock'); Absent = 'Safe sequence:' },
    @{ Name = 'Negative allocation'; File = 'invalid-negative.txt'; Code = 1; Match = @('Allocation\[0\]\[0\] cannot be negative') },
    @{ Name = 'Maximum below allocation'; File = 'invalid-maximum.txt'; Code = 1; Match = @('Maximum demand cannot be less than allocation') },
    @{ Name = 'Need equals Work and zero-need process'; Input = '2 1 0 1 1 1 0'; Code = 0; Match = @('Safe sequence: P1 -> P0') },
    @{ Name = 'One resource insufficient despite another being sufficient'; Input = '1 2 0 0 1 1 1 0'; Code = 0; Match = @('System is in an UNSAFE state') },
    @{ Name = 'Already complete process with no resources'; Input = '1 1 0 0 0'; Code = 0; Match = @('Safe sequence: P0') },
    @{ Name = 'Work accumulation beyond signed 32-bit range'; Input = '2 1 2147483647 0 2147483647 2147483647 1'; Code = 0; Trace = $true; Match = @('Safe sequence: P0 -> P1', 'Work \[2147483648\]') },
    @{ Name = 'Zero process count'; Input = '0 1'; Code = 1; Match = @('counts must be positive') },
    @{ Name = 'Negative resource count'; Input = '1 -1'; Code = 1; Match = @('cannot be negative') },
    @{ Name = 'Negative maximum'; Input = '1 1 0 -1 0'; Code = 1; Match = @('Maximum\[0\]\[0\] cannot be negative') },
    @{ Name = 'Negative availability'; Input = '1 1 0 1 -1'; Code = 1; Match = @('Available\[0\] cannot be negative') },
    @{ Name = 'Incomplete matrix'; Input = '2 2 0'; Code = 1; Match = @('Missing integer for Allocation') },
    @{ Name = 'Noninteger'; Input = 'one 1'; Code = 1; Match = @('Expected a 32-bit integer') },
    @{ Name = 'Input integer overflow'; Input = '1 1 0 2147483648 0'; Code = 1; Match = @('Expected a 32-bit integer') },
    @{ Name = 'Extra snapshot tokens'; Input = '1 1 0 0 0 99'; Code = 1; Match = @('Unexpected extra input') },
    @{ Name = 'Excessive dimensions'; Input = '2147483647 2'; Code = 1; Match = @('at most 1000000 cells') },
    @{ Name = 'Missing input file'; File = 'does-not-exist.txt'; Code = 1; Match = @('Invalid input:') }
)

$failed = 0
$index = 0
foreach ($testCase in $testCases) {
    $index++
    if ($testCase.File) {
        $inputPath = Join-Path $PSScriptRoot ('samples\' + $testCase.File)
    } else {
        $inputPath = Join-Path $buildPath "test-input-$index.txt"
        [IO.File]::WriteAllText($inputPath, $testCase.Input, [Text.Encoding]::ASCII)
    }
    $options = @('--input', $inputPath)
    if ($testCase.Trace) { $options += '--trace' }
    $output = (& $javaTools.Java -cp $buildPath HospitalDeadlock @options) -join "`n"
    $exitCode = $LASTEXITCODE
    $issues = @()
    if ($exitCode -ne $testCase.Code) { $issues += "exit $exitCode instead of $($testCase.Code)" }
    foreach ($pattern in $testCase.Match) {
        if ($output -notmatch $pattern) { $issues += "missing expected result: $pattern" }
    }
    if ($testCase.Absent -and $output -match $testCase.Absent) { $issues += "unexpected result: $($testCase.Absent)" }
    if ($issues.Count) {
        $failed++
        Write-Host "FAIL: $($testCase.Name): $($issues -join '; ')"
        Write-Host $output
    } else {
        Write-Host "PASS: $($testCase.Name)"
    }
}

# Standard-input mode must finish without interactive EOF prompts.
$stdinOutput = ('1 1 0 0 0' | & $javaTools.Java -cp $buildPath HospitalDeadlock) -join "`n"
if ($LASTEXITCODE -ne 0 -or $stdinOutput -notmatch 'Safe sequence: P0') {
    $failed++
    Write-Host 'FAIL: Standard-input mode'
} else { Write-Host 'PASS: Standard-input mode' }

$helpOutput = (& $javaTools.Java -cp $buildPath HospitalDeadlock --help) -join "`n"
if ($LASTEXITCODE -ne 0 -or $helpOutput -notmatch 'Usage: java HospitalDeadlock') {
    $failed++
    Write-Host 'FAIL: Help option'
} else { Write-Host 'PASS: Help option' }

$badOptionOutput = (& $javaTools.Java -cp $buildPath HospitalDeadlock --unknown) -join "`n"
if ($LASTEXITCODE -ne 1 -or $badOptionOutput -notmatch 'Unknown option') {
    $failed++
    Write-Host 'FAIL: Unknown option rejection'
} else { Write-Host 'PASS: Unknown option rejection' }

$missingPathOutput = (& $javaTools.Java -cp $buildPath HospitalDeadlock --input) -join "`n"
if ($LASTEXITCODE -ne 1 -or $missingPathOutput -notmatch 'followed by a file path') {
    $failed++
    Write-Host 'FAIL: Missing input path rejection'
} else { Write-Host 'PASS: Missing input path rejection' }

$total = $testCases.Count + 4
Write-Host "`n$($total - $failed)/$total checks passed."
if ($failed) { exit 1 }
exit 0
