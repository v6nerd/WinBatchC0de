@echo off
mode con:cols=90 lines=35

REM =================================================
REM Description: Set P&G IE Proxy Defaults
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM =================================================

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /t REG_SZ /d "http://autoproxy.pg.com:8080" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d "0" /f
