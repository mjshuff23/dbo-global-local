@echo off
setlocal EnableExtensions
set "NO_PAUSE="
if /I "%~1"=="-NoPause" set "NO_PAUSE=1"

echo.
echo === DBO Global - Shutdown ===
for %%P in (Client GameServer ChatServer CharServer AuthServer QueryServer MasterServer) do (
    tasklist /FI "IMAGENAME eq %%P.exe" /NH 2>nul | findstr /I /B /C:"%%P.exe" >nul
    if errorlevel 1 (
        echo Already stopped: %%P
    ) else (
        echo Stopping %%P...
        taskkill /F /T /IM "%%P.exe" >nul 2>&1
        if errorlevel 1 (
            echo Could not stop %%P.
            exit /b 1
        )
    )
)
echo All DBO client/server processes are stopped.

if not defined NO_PAUSE pause
exit /b 0
