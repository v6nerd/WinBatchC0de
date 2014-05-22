@echo off
mode con:cols=90 lines=35

REM ===========================================================
REM Description: Internet Explorer 8 - Cleanup
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ===========================================================

:delete_cookies
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2

:delete_history
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1

:delete_tempfiles
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8

:delete_passwords
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32

:delete_addon_data
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351

:reset_IE_settings
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults

:set_pg_proxy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /t REG_SZ /d "http://autoproxy.pg.com:8080" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d "0" /f