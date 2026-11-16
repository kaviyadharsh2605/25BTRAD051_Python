function Get-JavaTools {
    $javaHomes = @()
    if ($env:JAVA_HOME) { $javaHomes += $env:JAVA_HOME }
    $compiler = Get-Command javac.exe -ErrorAction SilentlyContinue
    if ($compiler) { $javaHomes += Split-Path (Split-Path $compiler.Source -Parent) -Parent }
    $userJdks = Join-Path $env:USERPROFILE '.jdks'
    if (Test-Path -LiteralPath $userJdks) {
        $javaHomes += Get-ChildItem -LiteralPath $userJdks -Directory | Sort-Object Name -Descending | Select-Object -ExpandProperty FullName
    }
    foreach ($javaHome in $javaHomes) {
        $javacPath = Join-Path $javaHome 'bin\javac.exe'
        $javaPath = Join-Path $javaHome 'bin\java.exe'
        if ((Test-Path -LiteralPath $javacPath) -and (Test-Path -LiteralPath $javaPath)) {
            return @{ Javac = $javacPath; Java = $javaPath }
        }
    }
    throw 'JDK 11 or newer is required. Set JAVA_HOME to the JDK folder or add its bin folder to PATH.'
}
