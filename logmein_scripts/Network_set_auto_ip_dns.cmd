@echo off
mode con:cols=90 lines=35

REM ===========================================================
REM Description: SET IP & DNS to Automatic on Active Interface
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ===========================================================

:set_ip_auto
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto set_auto_lan
if %ERRORLEVEL% EQU 1 goto find_wifi_iface

:set_auto_lan
netsh interface ipv4 set address name="%interface_name%" source=dhcp > nul
netsh interface ipv4 set dnsservers name="%interface_name%" source=dhcp > nul
echo. & echo ^[ == Changes has been successfully applied == ^] & exit

:find_wifi_iface
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected" ^| find
/i "wireless"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto set_auto_wlan
if %ERRORLEVEL% EQU 1 echo. & echo ^<^< Can't find active LAN/WLAN Connections ... Please Check! ^>^> & exit

:set_auto_wlan
netsh interface ipv4 set address name="%interface_name%" source=dhcp > nul
netsh interface ipv4 set dnsservers name="%interface_name%" source=dhcp > nul
echo. & echo ^[ == Changes has been successfully applied == ^] & exit