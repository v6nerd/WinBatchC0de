@echo off
mode con:cols=90 lines=35

REM ====================================================
REM Description: Install AvayaVPN (Offline Mode)
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ====================================================

:install_avaya
for /f "tokens=4" %%a in ('dir c:\swsetup\ ^| find /i "avaya"') DO SET install_dir=%%a
echo Installtion in progress please hold on for 2 to 5 minutes!
for /f "tokens=3" %%a in ('wmic product call install true^,""^,"C:\swsetup\%install_dir%\Avaya VPN Client.msi"') DO SET output_value=%%a
if %output_value:~0,1% EQU 0 echo. & echo ^[ == Avaya VPN has been Installed Successfully == ^] & echo. & echo Hold on! Restoring Original NvcProfile & goto restore_profile
if %output_value:~0,4% EQU 1603 echo. & echo ^<^< Avaya VPN (Offline SETUP) has failed! ^>^>  & exit

:restore_profile
cd c:\swsetup\AvayaVPNClient*
if %ERRORLEVEL% == 1 echo. & echo ^<^< Path not found please try to locate the file manually ^>^> & exit
dir %userprofile%\AppData\Local\Avaya\"Avaya VPN Client"\ > nul
if %ERRORLEVEL% == 1 echo. & echo ^<^< Destination path not found! Check if Avaya VPN Client is Installed ^>^> & exit
copy /V /Y NvcProfiles_U.dat %userprofile%\AppData\Local\Avaya\"Avaya VPN Client"\NvcProfiles_U.dat
if %ERRORLEVEL% == 0 echo. & echo ^[ ==  NvcProfile Has been successfully restored == ^] & exit
if %ERRORLEVEL% == 1 echo. & echo ^<^< File not found please try to locate the file manually ^>^> & exit