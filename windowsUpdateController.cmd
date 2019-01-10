@echo off
chcp 65001>nul

net session>nul 2>nul
if %errorLevel% GEQ 1 goto :startAsAdmin





call :logo
echo.^(^i^) Windows Update Controller is running...
>nul timeout /nobreak /t 1

echo.^(^?^) Are you sure^? ^(Enter or close^)
pause>nul





:menu
call :logo
echo.^(^>^) Choose action:
echo.     -1- Clear Windows Update distributions
echo.     -2- Disable Windows Update Center and remove all downloaded updates
echo.     -3- Enable Windows Update Center and launch it
echo.
set /p action=^> 

if "%action%" NEQ "1" if "%action%" NEQ "2" if "%action%" NEQ "3" goto :menu
call :action%action%





call :logo
echo.^(^i^) The work is completed^!
>nul timeout /nobreak /t 1

echo.^(^?^) Reload now^? ^(Enter or close^)
pause>nul

echo.^(^!^) Reboot^!
shutdown /r /t 5
>nul timeout /t 4
exit





:action1
echo.^(^i^) Removing downloaded Windows Update Center distributions of updates...
for /l %%i in (4,-1,1) do rd /s /q %WinDir%\SoftwareDistribution\Download
>nul timeout /nobreak /t 1
exit /b





:action2
echo.^(^i^) Terminating the Windows Update Center...
for /l %%i in (4,-1,1) do sc stop wuauserv
>nul timeout /nobreak /t 1



echo.^(^i^) Disabling Windows Update Center...
for /l %%i in (4,-1,1) do sc config wuauserv start=disabled
>nul timeout /nobreak /t 1



echo.^(^i^) Removing downloaded Windows Update Center distributions of updates...
for /l %%i in (4,-1,1) do rd /s /q %WinDir%\SoftwareDistribution\Download
>nul timeout /nobreak /t 1



echo.^(^i^) Closing access to downloaded Windows Update Center distributions of updates directory...
for /l %%i in (4,-1,1) do echo.>%WinDir%\SoftwareDistribution\Download
>nul timeout /nobreak /t 1
exit /b





:action3
echo.^(^i^) Enabling Windows Update Center...
for /l %%i in (4,-1,1) do sc config wuauserv start=auto
>nul timeout /nobreak /t 1



echo.^(^i^) Launching Windows Update Center...
for /l %%i in (4,-1,1) do sc start wuauserv
>nul timeout /nobreak /t 1



echo.^(^i^) Opening access to downloaded Windows Update Center distributions of updates directory...
for /l %%i in (4,-1,1) do del /q "%WinDir%\SoftwareDistribution\Download"
>nul timeout /nobreak /t 1
exit /b





:logo
title [MikronT] Windows Update Controller
color 0b
cls
echo.
echo.    [MikronT] ==^> Windows Update Controller
echo.
exit /b





:startAsAdmin
echo.Please, run as Admin!
>nul timeout /nobreak /t 3
exit