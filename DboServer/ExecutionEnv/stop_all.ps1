[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$processNames = @("Client", "GameServer", "ChatServer", "CharServer", "AuthServer", "QueryServer", "MasterServer")

Write-Host ""
Write-Host "=== DBO Global - Shutdown ===" -ForegroundColor Yellow

foreach ($name in $processNames) {
    $processes = @(Get-Process -Name $name -ErrorAction SilentlyContinue)
    if ($processes.Count -eq 0) {
        Write-Host "Already stopped: $name" -ForegroundColor DarkGray
        continue
    }

    foreach ($process in $processes) {
        Write-Host "Stopping $($process.Name) PID=$($process.Id)..." -ForegroundColor Cyan
        Stop-Process -Id $process.Id -Force
    }
}

$deadline = (Get-Date).AddSeconds(10)
do {
    $remaining = @(Get-Process -Name $processNames -ErrorAction SilentlyContinue)
    if ($remaining.Count -eq 0) {
        break
    }
    Start-Sleep -Milliseconds 250
} while ((Get-Date) -lt $deadline)

if ($remaining.Count -gt 0) {
    $names = ($remaining | ForEach-Object { "$($_.Name) PID=$($_.Id)" }) -join ", "
    throw "Some DBO processes are still running: $names"
}

Write-Host "All DBO client/server processes are stopped." -ForegroundColor Green
