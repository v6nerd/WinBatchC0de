@echo off
mode con:cols=90 lines=35

REM ================================================
REM Description: Fix Windows Spool Issue
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ================================================

:delete_spool_drivers
for /f "tokens=*" %%a in ('dir %windir%\system32\spool\drivers /b') do rd /s /q "%%a"
REM if %ERRORLEVEL% EQU 0 echo ^[ == STEP1 completed successfully == ^]

:reset_winreg_defaults
unzip -q -o spool_monitors_default.zip
reg import spool_monitors_default.reg
for /f "tokens=*" %%b in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\Print\Monitors ^| findstr "TCP/IP"') do SET query_result=%%b