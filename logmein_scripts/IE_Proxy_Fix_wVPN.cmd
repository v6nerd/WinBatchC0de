@echo off
mode con:cols=90 lines=35

REM =================================================
REM Description: Set P&G IE Proxy Defaults (VPN Mode)
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM =================================================

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "autoproxy.pg.com:8080" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "*.pg.com;*.local;127.0.0.1" /f