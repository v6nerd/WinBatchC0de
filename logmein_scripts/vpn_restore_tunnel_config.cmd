@echo off
mode con:cols=90 lines=35

REM ====================================================
REM Description: Restores VPN Tunnel Configurations
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ====================================================

:restore_profile
cd c:\swsetup\AvayaVPNClient*
if %ERRORLEVEL% == 1 echo. & echo ^<^< Path not found please try to locate the file manually ^>^> & exit
dir %userprofile%\AppData\Local\Avaya\"Avaya VPN Client"\ > nul
if %ERRORLEVEL% == 1 echo. & echo ^<^< Destination path not found! Check if Avaya VPN Client is Installed ^>^> & exit
copy /V /Y NvcProfiles_U.dat %userprofile%\AppData\Local\Avaya\"Avaya VPN Client"\NvcProfiles_U.dat
if %ERRORLEVEL% == 0 echo. & echo ^[ ==  NvcProfile Has been successfully restored == ^] & exit
if %ERRORLEVEL% == 1 echo. & goto restore_profile_local

:restore_profile_local
unzip -q -o nvc_profile.zip
copy /V /Y NvcProfiles_U.dat %userprofile%\AppData\Local\Avaya\"Avaya VPN Client"\NvcProfiles_U.dat
if %ERRORLEVEL% == 0 echo. & echo ^[ ==  NvcProfile Has been successfully restored == ^] & exit