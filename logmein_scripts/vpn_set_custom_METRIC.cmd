@echo off
mode con:cols=90 lines=35

REM ====================================================
REM Description: Set Custom Routing Metric for VPN
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ====================================================

:set_iface_metric
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected" ^| find
/i "local"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto change_metric_lan 
if %ERRORLEVEL% EQU 1 goto wifi_interface

:change_metric_lan
netsh interface ipv4 set interface interface="%interface_name%" metric=40 > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & exit

:wifi_interface
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected" ^| find
/i "wireless"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto change_metric_wifi
if %ERRORLEVEL% EQU 1 goto any_interface

:change_metric_wifi
netsh interface ipv4 set interface interface="%interface_name%" metric=40 > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & exit

:any_interface
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto change_any_interface
if %ERRORLEVEL% EQU 1 goto echo can't find any CONNECTED Interface ... please Check!

:change_any_interface
netsh interface ipv4 set interface interface="%interface_name%" metric=40 > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & exit