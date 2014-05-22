@echo off
mode con:cols=90 lines=35

REM ===================================================
REM Description: Delete Windows stored Credentials 
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ===================================================

:clear_stored_credentials
for /f "tokens=2 delims= " %%a in ('cmdkey /list ^| findstr /I "LegacyGeneric"') do SET target=%%a
cmdkey /delete:%target% > nul 

if %ERRORLEVEL% EQU 1 echo Stored Credentials Cleared Successfully! & exit
if %ERRORLEVEL% EQU 0 goto clear_stored_credentials