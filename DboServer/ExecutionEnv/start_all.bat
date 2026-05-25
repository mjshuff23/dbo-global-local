@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "SERVER_DIR=%~dp0"
for %%I in ("%SERVER_DIR%..\..\DboClient\DragonBall") do set "CLIENT_DIR=%%~fI"
set "NO_CLIENT="
set "RESTART="

:parse_args
if "%~1"=="" goto args_done
if /I "%~1"=="-NoClient" (
    set "NO_CLIENT=1"
    shift
    goto parse_args
)
if /I "%~1"=="-Restart" (
    set "RESTART=1"
    shift
    goto parse_args
)
if /I "%~1"=="-ClientDir" (
    if "%~2"=="" (
        echo Missing path after -ClientDir.
        exit /b 1
    )
    for %%I in ("%~2") do set "CLIENT_DIR=%%~fI"
    shift
    shift
    goto parse_args
)
echo Unknown option: %~1
exit /b 1

:args_done
for %%F in (
    MasterServer.exe
    QueryServer.exe
    AuthServer.exe
    CharServer.exe
    ChatServer.exe
    GameServer.exe
    config\AuthServer.ini
    config\CharServer.ini
    config\ChatServer.ini
    config\GameServer.ini
) do (
    if not exist "%SERVER_DIR%%%F" (
        echo Required file not found: %SERVER_DIR%%%F
        exit /b 1
    )
)
if not exist "%CLIENT_DIR%\Client.exe" (
    echo Required client not found: %CLIENT_DIR%\Client.exe
    exit /b 1
)
if not exist "%CLIENT_DIR%\ConfigOptions.xml" (
    echo Required client config not found: %CLIENT_DIR%\ConfigOptions.xml
    exit /b 1
)

for /f "tokens=2 delims==" %%A in ('findstr /B /C:"Address =" "%SERVER_DIR%config\AuthServer.ini"') do (
    for /f "tokens=*" %%B in ("%%A") do if not defined PUBLIC_ADDRESS set "PUBLIC_ADDRESS=%%B"
)
for /f "tokens=2 delims==" %%A in ('findstr /B /C:"Port =" "%SERVER_DIR%config\AuthServer.ini"') do (
    for /f "tokens=*" %%B in ("%%A") do if not defined AUTH_PORT set "AUTH_PORT=%%B"
)
if not defined PUBLIC_ADDRESS (
    echo Could not read the AuthServer address from config\AuthServer.ini.
    exit /b 1
)
if not defined AUTH_PORT (
    echo Could not read the AuthServer port from config\AuthServer.ini.
    exit /b 1
)

if defined RESTART (
    call "%SERVER_DIR%stop_all.bat" -NoPause
    if errorlevel 1 exit /b 1
) else (
    for %%P in (MasterServer QueryServer AuthServer CharServer ChatServer GameServer) do (
        tasklist /FI "IMAGENAME eq %%P.exe" /NH 2>nul | findstr /I /B /C:"%%P.exe" >nul
        if not errorlevel 1 (
            echo DBO servers are already running. Use stop_all.bat first, or run start_all.bat -Restart.
            exit /b 1
        )
    )
)

echo.
echo === DBO Global - Single Channel Tailscale Startup ===
echo Client endpoint: %PUBLIC_ADDRESS%:%AUTH_PORT%
echo Client folder:   %CLIENT_DIR%
echo.

pushd "%SERVER_DIR%"
echo Starting MasterServer...
start "DBOG Master Server" "MasterServer.exe"
call :wait_listener "127.0.0.1:40001" "MasterServer/Auth internal endpoint" 30
if errorlevel 1 goto startup_failed

echo Starting QueryServer...
start "DBOG Query Server" "QueryServer.exe"
call :wait_listener "127.0.0.1:41001" "QueryServer/Game internal endpoint" 30
if errorlevel 1 goto startup_failed

echo Starting AuthServer...
start "DBOG Auth Server" "AuthServer.exe"
call :wait_listener "%PUBLIC_ADDRESS%:%AUTH_PORT%" "AuthServer" 30
if errorlevel 1 goto startup_failed

echo Starting CharServer...
start "DBOG Character Server" "CharServer.exe" ".\config\CharServer.ini"
call :wait_listener "%PUBLIC_ADDRESS%:20300" "CharServer" 30
if errorlevel 1 goto startup_failed

echo Starting ChatServer...
start "DBOG Chat Server" "ChatServer.exe"
call :wait_listener "%PUBLIC_ADDRESS%:20400" "ChatServer" 30
if errorlevel 1 goto startup_failed
call :wait_listener "127.0.0.1:21400" "ChatServer/Game internal endpoint" 30
if errorlevel 1 goto startup_failed

echo Starting GameServer channel 0...
start "DBOG Game Server - Channel 0" "GameServer.exe" ".\config\GameServer.ini"
call :wait_listener "%PUBLIC_ADDRESS%:30000" "GameServer channel 0" 240
if errorlevel 1 goto startup_failed
popd

echo.
echo All six servers are ready. Only GameServer channel 0 was started.
if not defined NO_CLIENT (
    tasklist /FI "IMAGENAME eq Client.exe" /NH 2>nul | findstr /I /B /C:"Client.exe" >nul
    if errorlevel 1 (
        echo Launching playable client...
        pushd "%CLIENT_DIR%"
        start "DragonBallOnline Global" "Client.exe"
        popd
    ) else (
        echo Client.exe is already running; not opening a duplicate client.
    )
)
exit /b 0

:startup_failed
popd
echo.
echo DBO startup failed. Run stop_all.bat before trying again.
exit /b 1

:wait_listener
set "WAIT_ADDRESS=%~1"
set "WAIT_LABEL=%~2"
set /a "WAIT_SECONDS=%~3"
:wait_loop
netstat -ano -p tcp | findstr /C:"%WAIT_ADDRESS%" | findstr /C:"LISTENING" >nul
if not errorlevel 1 (
    echo   Ready: %WAIT_LABEL% ^(%WAIT_ADDRESS%^)
    exit /b 0
)
if !WAIT_SECONDS! LEQ 0 (
    echo Timed out waiting for %WAIT_LABEL% on %WAIT_ADDRESS%.
    exit /b 1
)
ping -n 2 127.0.0.1 >nul
set /a WAIT_SECONDS-=1
goto wait_loop
