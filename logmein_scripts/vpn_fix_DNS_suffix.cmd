@echo off
mode con:cols=90 lines=35

REM ==============================================================
REM Description: Fixes Duplicate DNS Suffix Entries
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ==============================================================

:fix_dns_suffix
reg add HKLM\System\currentcontrolset\services\tcpip\parameters /v "SearchList" /d "eu.pg.com,ap.pg.com,pg.com,na.pg.com,la.pg.com" /f > nul
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == DNS suffix entries applied successfully!  == ^] & echo. & goto reboot_now
if %ERRORLEVEL% EQU 1 echo. & echo ^<^< Failed! re-run the tool with adminestrative privilages ^>^> & exit

:reboot_now
shutdown /r /t 120 
exit