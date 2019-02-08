@echo off
chcp 65001>nul

net session>nul 2>nul
if %errorLevel% GEQ 1 goto :startAsAdmin





call :logo
echo.^(^i^) Windows Update Controller is running...
timeout /nobreak /t 1 >nul

echo.^(^?^) Are you sure^? ^(Enter or close^)
pause>nul





call :logo
echo.^(^>^) Choose action:
echo.     -1- Clear Windows Update distributions
echo.     -2- Disable Windows Update Center and remove all downloaded updates
echo.     -3- Enable Windows Update Center and launch it
echo.
choice /c 123 /n /m "> "
call :action%errorLevel%





call :logo
echo.^(^i^) The work is completed^!
timeout /nobreak /t 1 >nul

echo.^(^?^) Reload now^? ^(Enter or close^)
pause>nul

echo.^(^!^) Reboot^!
shutdown /r /t 5
timeout /t 4 >nul
exit





:action1
echo.^(^i^) Removing downloaded Windows Update Center distributions of updates...
for /l %%i in (4,-1,1) do rd /s /q "%WinDir%\SoftwareDistribution\Download"
timeout /nobreak /t 1 >nul
exit /b





:action2
echo.^(^i^) Terminating the Windows Update Center...
for /l %%i in (4,-1,1) do sc stop wuauserv
timeout /nobreak /t 1 >nul



echo.^(^i^) Disabling Windows Update Center...
for /l %%i in (4,-1,1) do sc config wuauserv start=disabled
timeout /nobreak /t 1 >nul



echo.^(^i^) Removing downloaded Windows Update Center distributions of updates...
for /l %%i in (4,-1,1) do rd /s /q "%WinDir%\SoftwareDistribution\Download"
timeout /nobreak /t 1 >nul



echo.^(^i^) Closing access to downloaded Windows Update Center distributions of updates directory...
for /l %%i in (4,-1,1) do echo.>"%WinDir%\SoftwareDistribution\Download"
timeout /nobreak /t 1 >nul
exit /b





:action3
echo.^(^i^) Opening access to downloaded Windows Update Center distributions of updates directory...
for /l %%i in (4,-1,1) do del /q "%WinDir%\SoftwareDistribution\Download"
timeout /nobreak /t 1 >nul



echo.^(^i^) Enabling Windows Update Center...
for /l %%i in (4,-1,1) do sc config wuauserv start=auto
timeout /nobreak /t 1 >nul



echo.^(^i^) Launching Windows Update Center...
for /l %%i in (4,-1,1) do sc start wuauserv
timeout /nobreak /t 1 >nul
exit /b





:logo
title [MikronT] Windows Update Controller
color 0b
cls
echo.
echo.
echo.    [MikronT] ==^> Windows Update Controller
echo.                  Release v1.0
echo.   ==========================================
echo.     See other here:
echo.         github.com/MikronT
echo.
echo.                  Will no longer be updated^!
echo.                  Merged with Ten Tweaker
echo.
echo.
echo.
exit /b





:startAsAdmin
echo.^(^!^) Please, run as Admin^!
timeout /nobreak /t 3 >nul
exit