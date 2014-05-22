@echo off
mode con:cols=90 lines=35

REM ==============================================================
REM Description: ALL-IN-ONE Avaya VPN 10 Troubleshooting Utility
REM	
REM Type: BatchScript
REM
REM Version: 1.0 REV 13
REM
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ==============================================================

REM == check for admin rights ==
:pre_run_check
net session > nul
if %ERRORLEVEL% EQU 0 goto main_menu
if %ERRORLEVEL% EQU 2 cls & echo. & echo ^<^< You'll Need to re-launch this TOOL as Administrator ^>^> & goto exit_menu

:main_menu
cls
echo.
echo    *******************************************
echo      ALL-IN-ONE Avaya VPN v10 Troubleshooter
echo            FOR P^&G TECH Team USE ONLY	
echo    *******************************************
echo.
echo.
echo  1. Check Avaya VPN (Running Services)
echo. 
echo  2. Restore Default DNS Suffix Entries
echo. 
echo  3. FixBFE (Base Filtering Engine)
echo. 
echo  4. Set a CUSTOM DNS Metric to 40
echo.
echo  5. Set IPv4/DNS to Automatic
echo. 
echo  6. Uninstall Avaya VPN Client
echo. 
echo  7. Install Avaya VPN Client (offline mode)
echo.
echo  8. Restore Original NVC Profile (Tunnel Configuration)
echo.
echo  9. Fix Banner Acknowledgment Issue  
echo.
echo  10. Do Nothing! Just Exit
echo.

SET /P option=  Please choose one of these options to proceed:

if /i %option%==1 goto chk_vpn_svc
if /i %option%==2 goto fix_dns_suffix
if /i %option%==3 goto fix_bfe
if /i %option%==4 goto set_iface_metric
if /i %option%==5 goto set_ip_auto
if /i %option%==6 goto uninstall_avaya
if /i %option%==7 goto install_avaya
if /i %option%==8 goto restore_profile
if /i %option%==9 goto fix_banner
if /i %option%==10 goto exit

REM == Exit Menu starts HERE ==
:exit_menu
echo.
echo 1.Return to Main Menu
echo 2.Quit!
SET /P option=  Please choose one of these options to proceed:
if /i %option%==1 goto :main_menu
if /i %option%==2 goto :exit

REM == Section 1 starts HERE ==

:chk_vpn_svc
sc query BFE | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 goto BFE_launch
if %ERRORLEVEL% EQU 0 goto chk_IKEEXT
:BFE_launch
echo Trying to start The Base Filtering Engine (BFE) ... wait!
sc start BFE > nul
if %ERRORLEVEL% EQU 1060 echo. & echo ^<^< Please Use option 3 FixBFE ^>^> & goto exit_menu
timeout /T 15 > nul
sc query BFE | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 echo & echo. ^<^< Please Use option 3 FixBFE ^>^> & goto exit_menu
if %ERRORLEVEL% EQU 0 goto chk_IKEEXT
:chk_IKEEXT
sc query IKEEXT | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 goto IKEEXT_launch
if %ERRORLEVEL% EQU 0 goto chk_NvCSvc
:IKEEXT_launch
sc start IKEEXT
if %ERRORLEVEL% EQU 1060 echo. & echo ^<^< Please Use option 3 FixBFE ^>^> & goto exit_menu
if %ERRORLEVEL% EQU 0 goto chk_NvcSvc
timeout /T 15 > nul
sc query IKEEXT | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 0 goto chk_NvcSvc
if %ERRORLEVEL% EQU 1 echo & echo. ^<^< Please Use option 3 FixBFE ^>^> & goto exit_menu
:chk_NvcSvc
sc query NvcSvcMgr | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 goto NvcSvc_launch
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Avaya VPN 10 Services are Running properly == ^] & goto exit_menu
:NvcSvC_launch
sc start NvcSvcMgr > nul
if %ERRORLEVEL% EQU 1060 echo. & echo  ^<^< Avaya VPN 10 is not Installed Please re-install. ^>^> & goto exit_menu

REM == Section 2 starts HERE ==

:fix_dns_suffix
reg add HKLM\System\currentcontrolset\services\tcpip\parameters /v "SearchList" /d "eu.pg.com,ap.pg.com,pg.com,na.pg.com,la.pg.com,gnet.gillette.com" /f > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == DNS suffix entries applied successfully!  == ^] & echo. & goto pc_reboot
if %ERRORLEVEL% EQU 1 echo. & echo ^<^< Failed! re-run the tool with adminestrative privilages ^>^> & goto exit_menu

REM == Section 3 starts HERE ==

:fix_bfe
cd /d %~dp0\support_files
REG IMPORT BFE_fix.reg > nul
if %ERRORLEVEL% EQU 0 goto check_bfe_key
if %ERRORLEVEL% EQU 1 echo. & echo ^<^< Unable to locate BFE_fix registry file ^>^> & goto exit_menu

:check_bfe_key
reg query HKLM\SYSTEM\CurrentControlSet\services\BFE | findstr /i "bfe.dll" > nul

if %ERRORLEVEL% EQU 0 goto fix_bfe_permissions
if %ERRORLEVEL% EQU 1 echo. & echo ^<^< BFE Fix Was not applied! re-run once again ^>^> & goto exit_menu

:fix_bfe_permissions
echo ^\Registry^\Machine^\SYSTEM^\CurrentControlSet^\services^\BFE [1 5 7 17] > bfe_perm_fix.txt
regini bfe_perm_fix.txt > nul

if %ERRORLEVEL% EQU 0 echo. & echo BFE Fix was applied successfully.
if %ERRORLEVEL% EQU 1 echo. & echo ^<^< Unable to locate BFE_fix registry file ^>^> & goto exit_menu

:pc_reboot
SET /P reboot=Would you like to Reboot your PC now (y/n):
if /i %reboot%==y goto reboot_now
if /i %reboot%==yes goto reboot_now
if /i %reboot%==n echo. & echo ^(^( Changes may not take effect until the system is Rebooted ^)^) & goto exit_menu
if /i %reboot%==no goto exit_menu

:reboot_now
shutdown /r /t 120 
exit

REM == Section 4 starts HERE ==

:set_iface_metric
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected" ^| find
/i "local"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto change_metric_lan 
if %ERRORLEVEL% EQU 1 goto wifi_interface

:change_metric_lan
netsh interface ipv4 set interface interface="%interface_name%" metric=40 > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & goto exit_menu
:wifi_interface
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected" ^| find
/i "wireless"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto change_metric_wifi
if %ERRORLEVEL% EQU 1 goto goto any_interface

:change_metric_wifi
netsh interface ipv4 set interface interface="%interface_name%" metric=40 > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & goto exit_menu

:any_interface
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto change_any_interface
if %ERRORLEVEL% EQU 1 goto echo can't find any CONNECTED Interface ... please Check!

:change_any_interface
netsh interface ipv4 set interface interface="%interface_name%" metric=40 > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & goto exit_menu

REM == Section 5 Starts HERE ==

:set_ip_auto
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto set_auto_lan
if %ERRORLEVEL% EQU 1 goto find_wifi_iface

:set_auto_lan
netsh interface ipv4 set address name="%interface_name%" source=dhcp > nul
netsh interface ipv4 set dnsservers name="%interface_name%" source=dhcp > nul
echo. & echo ^[ == Changes has been successfully applied == ^] & goto exit_menu

:find_wifi_iface
for /f "tokens=4*" %%a in ('netsh interface show interface ^| find /i "connected" ^| find
/i "wireless"') DO SET interface_name=%%a %%b
if %ERRORLEVEL% EQU 0 goto set_auto_wlan
if %ERRORLEVEL% EQU 1 echo. & echo ^<^< Can't find active LAN/WLAN Connections ... Please Check! ^>^> & goto exit_menu

:set_auto_wlan
netsh interface ipv4 set address name="%interface_name%" source=dhcp > nul
netsh interface ipv4 set dnsservers name="%interface_name%" source=dhcp > nul
echo. & echo ^[ == Changes has been successfully applied == ^] & goto exit_menu



REM == Section 6 starts HERE ==

:uninstall_avaya
echo Uninstalltion in progress please hold on for 2 to 5 minutes!
for /f %%a in ('wmic product where name^="Avaya VPN Client" call uninstall') DO SET output_value=%%a
if %output_value:~0,2% EQU No goto :uninstall_error
if %output_value:~0,2% NEQ No goto :uninstall_success
 
:uninstall_success
echo. & echo ^[ ==  Avaya VPN has been Uninstalled Successfully == ^] & goto exit_menu
 
:uninstall_error
echo. & echo ^<^< Avaya VPN is not Installed or can't be removed. ^>^> & goto exit_menu



REM == Section 7 starts HERE ==

:install_avaya
for /f "tokens=4" %%a in ('dir c:\swsetup\ ^| find /i "avaya"') DO SET install_dir=%%a
echo Installtion in progress please hold on for 2 to 5 minutes!
for /f "tokens=3" %%a in ('wmic product call install true^,""^,"C:\swsetup\%install_dir%\Avaya VPN Client.msi"') DO SET output_value=%%a
if %output_value:~0,1% EQU 0 echo. & echo ^[ == Avaya VPN has been Installed Successfully == ^] & echo. & echo Hold on! Restoring Original NvcProfile & goto restore_profile
if %output_value:~0,4% EQU 1603 echo. & echo ^<^< Avaya VPN (Offline SETUP) has failed! ^>^>  & goto exit_menu

REM // check installtion paths, filename //


REM == Section 8 starts HERE ==

:restore_profile
cd c:\swsetup\AvayaVPNClient*
if %ERRORLEVEL% == 1 echo. & echo ^<^< Path not found please try to locate the file manually ^>^> & goto exit_menu
dir %userprofile%\AppData\Local\Avaya\"Avaya VPN Client"\ > nul
if %ERRORLEVEL% == 1 echo. & echo ^<^< Destination path not found! Check if Avaya VPN Client is Installed ^>^> & goto exit_menu
copy /V /Y NvcProfiles_U.dat %userprofile%\AppData\Local\Avaya\"Avaya VPN Client"\NvcProfiles_U.dat
if %ERRORLEVEL% == 0 echo. & echo ^[ ==  NvcProfile Has been successfully restored == ^] & goto exit_menu
if %ERRORLEVEL% == 1 echo. & echo ^<^< File not found please try to locate the file manually ^>^> & goto exit_menu


REM == Section 9 starts HERE ==

:fix_banner
REM wmic os get OSArchitecture | find /i "64-bit" > nul
REM if %ERRORLEVEL% EQU 0 goto fix_banner_x64
REM %ERRORLEVEL% EQU 1 goto fix_banner_x86

:fix_banner_x86
cd /d %~dp0\support_files
devcon_x86.exe remove *6to4mp > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & goto exit_menu
if %ERRORLEVEL% EQU 1 echo. & echo echo. & echo ^<^< File not found please check if support_files is located on the same folder ^>^> & goto exit_menu

:fix_banner_x64
cd /d %~dp0\support_files
devcon_x64.exe remove *6to4mp > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & goto exit_menu
if %ERRORLEVEL% EQU 1 echo. & echo echo. & echo ^<^< File not found please check if support_files is located on the same folder ^>^> & goto exit_menu

REM == Section 10 starts HERE ==
:exit
pause
cd /d %~dp0 & rd /Q /S support_files & del /Q AvayaVPN_AIO.cmd & exit /B > nul