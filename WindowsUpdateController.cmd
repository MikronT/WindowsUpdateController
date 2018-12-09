@echo off
chcp 65001



call :logo
echo.^(^?^) Ви впевнені^? ^(Enter або закрийте вікно^)
pause>nul

:start
call :logo
echo.^(^!^) Запуск [ADSI] Windows Update Controller...
>nul timeout /nobreak /t 1





echo.^(^>^) Виберіть дію:
echo.     -1- Очистити дистрибутиви оновлень Windows
echo.     -2- Вимкнути Центр оновлення Windows та видалити всі завантажені оновлення
echo.     -3- Увімкнути Центр оновлення Windows та запустити його роботу
set /p action=^> 

if "%action%" NEQ "1" if "%action%" NEQ "2" if "%action%" NEQ "3" goto :start
call :action%action%





call :logo
echo.^(^!^) Роботу завершено^!
>nul timeout /nobreak /t 1

echo.^(^!^) Перезагрузка через 30 секунд^!
shutdown /r /t 30
>nul timeout /t 30
exit





:action1
echo.^(^!^) Видалення завантажених дистрибутивів оновлень Центра оновлення Windows...
rd /s /q %WinDir%\SoftwareDistribution\Download
rd /s /q %WinDir%\SoftwareDistribution\Download
rd /s /q %WinDir%\SoftwareDistribution\Download
rd /s /q %WinDir%\SoftwareDistribution\Download
>nul timeout /nobreak /t 1
exit /b





:action2
echo.^(^!^) Термінація роботи Центра оновлення Windows...
sc stop wuauserv
sc stop wuauserv
sc stop wuauserv
sc stop wuauserv
>nul timeout /nobreak /t 1



echo.^(^!^) Вимкнення Центра оновлення Windows...
sc config wuauserv start=disabled
sc config wuauserv start=disabled
sc config wuauserv start=disabled
sc config wuauserv start=disabled
>nul timeout /nobreak /t 1



echo.^(^!^) Видалення завантажених дистрибутивів оновлень Центра оновлення Windows...
rd /s /q %WinDir%\SoftwareDistribution\Download
rd /s /q %WinDir%\SoftwareDistribution\Download
rd /s /q %WinDir%\SoftwareDistribution\Download
rd /s /q %WinDir%\SoftwareDistribution\Download
>nul timeout /nobreak /t 1



echo.^(^!^) Закриття доступу до завантажених дистрибутивів оновлень Центра оновлення Windows...
echo.>%WinDir%\SoftwareDistribution\Download
echo.>%WinDir%\SoftwareDistribution\Download
echo.>%WinDir%\SoftwareDistribution\Download
echo.>%WinDir%\SoftwareDistribution\Download
>nul timeout /nobreak /t 3
exit /b





:action3
echo.^(^!^) Увімкнення Центра оновлення Windows...
sc config wuauserv start=auto
sc config wuauserv start=auto
sc config wuauserv start=auto
sc config wuauserv start=auto
>nul timeout /nobreak /t 1



echo.^(^!^) Запуск роботи Центра оновлення Windows...
sc start wuauserv
sc start wuauserv
sc start wuauserv
sc start wuauserv
>nul timeout /nobreak /t 1
exit /b





:logo
title [ADSI] Windows Update Controller
color 0b
cls
echo.
echo.    [ADSI] ==^> Windows Update Controller
echo.
exit /b