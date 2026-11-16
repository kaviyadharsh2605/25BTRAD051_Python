param(
    [string]$InputFile,
    [switch]$Trace
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'scripts\Get-JavaTools.ps1')
$javaTools = Get-JavaTools
$buildPath = Join-Path $PSScriptRoot 'build'
New-Item -ItemType Directory -Path $buildPath -Force | Out-Null
& $javaTools.Javac --release 11 -d $buildPath (Join-Path $PSScriptRoot 'HospitalDeadlock.java')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
$javaArguments = @('-cp', $buildPath, 'HospitalDeadlock')
if ($InputFile) { $javaArguments += @('--input', (Resolve-Path -LiteralPath $InputFile).Path) }
if ($Trace) { $javaArguments += '--trace' }
& $javaTools.Java @javaArguments
exit $LASTEXITCODE
