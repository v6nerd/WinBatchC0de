@echo off
mode con:cols=90 lines=35

REM ====================================================
REM Description: Uninstall AvayaVPN 10
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ====================================================

:uninstall_avaya
echo Uninstalltion in progress please hold on for 2 to 5 minutes!
for /f %%a in ('wmic product where name^="Avaya VPN Client" call uninstall') DO SET output_value=%%a
if %output_value:~0,2% EQU No goto :uninstall_error
if %output_value:~0,2% NEQ No goto :uninstall_success
 
:uninstall_success
echo. & echo ^[ ==  Avaya VPN has been Uninstalled Successfully == ^] & goto exit_menu
 
:uninstall_error
echo. & echo ^<^< Avaya VPN is not Installed or can't be removed. ^>^> & goto exit_menu