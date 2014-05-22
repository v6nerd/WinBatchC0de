@echo off
mode con:cols=90 lines=35

REM ====================================================
REM Description: Fix AvayaVPN Banner Issue 
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ====================================================

REM :fix_banner
REM wmic os get OSArchitecture | find /i "64-bit" > nul
REM if %ERRORLEVEL% EQU 0 goto fix_banner_x64
REM if %ERRORLEVEL% EQU 1 goto fix_banner_x86

:fix_banner_x86
unzip -q -o devcon_exec.zip -x devcon_x64.exe
REM cd /d %~dp0\support_files
devcon_x86.exe remove *6to4mp > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & exit
if %ERRORLEVEL% EQU 1 echo. & echo echo. & echo ^<^< File not found please check if support_files is located on the same folder ^>^> & exit

:fix_banner_x64
unzip -q -o devcon_exec.zip -x devcon_x86.exe
REM cd /d %~dp0\support_files
devcon_x64.exe remove *6to4mp > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Changes has been successfully applied == ^] & exit
if %ERRORLEVEL% EQU 1 echo. & echo echo. & echo ^<^< File not found please check if support_files is located on the same folder ^>^> & exit