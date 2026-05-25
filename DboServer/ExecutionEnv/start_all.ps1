[CmdletBinding()]
param(
    [switch]$NoClient,
    [switch]$Restart
)

$ErrorActionPreference = "Stop"
$serverDir = $PSScriptRoot
$clientDir = [System.IO.Path]::GetFullPath((Join-Path $serverDir "..\..\DboClient\DragonBall"))
$clientExe = Join-Path $clientDir "Client.exe"
$clientConfig = Join-Path $clientDir "ConfigOptions.xml"
$serverNames = @("MasterServer", "QueryServer", "AuthServer", "CharServer", "ChatServer", "GameServer")

function Require-Path {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Required file not found: $Path"
    }
}

function Wait-Listener {
    param(
        [string]$Address,
        [int]$Port,
        [string]$Label,
        [int]$TimeoutSeconds = 30
    )

    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    do {
        $listener = Get-NetTCPConnection -State Listen -LocalPort $Port -ErrorAction SilentlyContinue
        if ($listener) {
            Write-Host "  Ready: $Label ($Address`:$Port)" -ForegroundColor Green
            return
        }
        Start-Sleep -Milliseconds 500
    } while ((Get-Date) -lt $deadline)

    throw "Timed out waiting for $Label on $Address`:$Port."
}

function Start-DboServer {
    param(
        [string]$Exe,
        [string]$Label,
        [string[]]$Arguments = @()
    )

    Write-Host "Starting $Label..." -ForegroundColor Cyan
    $path = Join-Path $serverDir $Exe
    if ($Arguments.Count -gt 0) {
        Start-Process -FilePath $path -WorkingDirectory $serverDir -ArgumentList $Arguments | Out-Null
    } else {
        Start-Process -FilePath $path -WorkingDirectory $serverDir | Out-Null
    }
}

foreach ($file in @(
    "MasterServer.exe",
    "QueryServer.exe",
    "AuthServer.exe",
    "CharServer.exe",
    "ChatServer.exe",
    "GameServer.exe",
    "config\AuthServer.ini",
    "config\CharServer.ini",
    "config\ChatServer.ini",
    "config\GameServer.ini"
)) {
    Require-Path (Join-Path $serverDir $file)
}
Require-Path $clientExe
Require-Path $clientConfig

[xml]$clientOptions = Get-Content -LiteralPath $clientConfig
$publicAddress = [string]$clientOptions.config_options.op.ip
$authPort = [int]$clientOptions.config_options.op.port
if ([string]::IsNullOrWhiteSpace($publicAddress) -or $authPort -le 0) {
    throw "Could not read the authentication endpoint from $clientConfig."
}

if ($Restart) {
    & (Join-Path $serverDir "stop_all.ps1")
} else {
    $runningServers = @(Get-Process -Name $serverNames -ErrorAction SilentlyContinue)
    if ($runningServers.Count -gt 0) {
        $names = ($runningServers | Select-Object -ExpandProperty Name -Unique) -join ", "
        throw "DBO servers are already running ($names). Use stop_all.bat first, or run start_all.bat -Restart."
    }
}

Write-Host ""
Write-Host "=== DBO Global - Single Channel Tailscale Startup ===" -ForegroundColor Yellow
Write-Host "Client endpoint: $publicAddress`:$authPort"
Write-Host "Client folder:   $clientDir"
Write-Host ""

Start-DboServer "MasterServer.exe" "MasterServer"
Wait-Listener "127.0.0.1" 40001 "MasterServer/Auth internal endpoint"

Start-DboServer "QueryServer.exe" "QueryServer"
Wait-Listener "127.0.0.1" 41001 "QueryServer/Game internal endpoint"

Start-DboServer "AuthServer.exe" "AuthServer"
Wait-Listener $publicAddress $authPort "AuthServer"

Start-DboServer "CharServer.exe" "CharServer" @(".\config\CharServer.ini")
Wait-Listener $publicAddress 20300 "CharServer"

Start-DboServer "ChatServer.exe" "ChatServer"
Wait-Listener $publicAddress 20400 "ChatServer"
Wait-Listener "127.0.0.1" 21400 "ChatServer/Game internal endpoint"

Start-DboServer "GameServer.exe" "GameServer channel 0" @(".\config\GameServer.ini")
Wait-Listener $publicAddress 30000 "GameServer channel 0" 240

Write-Host ""
Write-Host "All six servers are ready. Only GameServer channel 0 was started." -ForegroundColor Green

if (-not $NoClient) {
    $existingClient = @(Get-Process -Name "Client" -ErrorAction SilentlyContinue)
    if ($existingClient.Count -eq 0) {
        Write-Host "Launching client..." -ForegroundColor Cyan
        Start-Process -FilePath $clientExe -WorkingDirectory $clientDir | Out-Null
    } else {
        Write-Host "Client.exe is already running; not opening a duplicate client." -ForegroundColor Yellow
    }
}

Write-Host "Use stop_all.bat (Windows) or ./stop_all.sh (WSL) to shut everything down." -ForegroundColor DarkGray
