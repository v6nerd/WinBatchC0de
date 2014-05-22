@echo on
mode con:cols=90 lines=35

REM ====================================================
REM Description: One-Click Frequent Lockout PRE-Fix
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ====================================================

:clean_IE_passwords_cookies
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2

:clean_chrome_cache
set chrome_cache="%homedrive%\Users\%username%\AppData\Local\Google\Chrome\User Data\Default"
del /q /s /f %chrome_cache%\Login-Data*.*
del /q /s /f %chrome_cache%\Cookies*.*

REM :clean_firefox_cache
REM set firefox_cache="%homedrive%\Users\%username%\AppData\Local\Mozilla\Firefox\Profiles"

:unmount_shared_drives
wmic logicaldisk where description="Network Drive" get name > %~dp0\net_drives.txt
for /f "tokens=* skip=1 delims=:" %%a in ('type ~%dp0\net_drives.txt') DO set drive=%%a
IF %ERRORLEVEL% EQU 0 net use /delete %drive% 
IF %ERRORLEVEL% EQU 1 goto kill_processes

:kill_processes
wmic process where name="nwtray.exe" call terminate
wmic process where name="outlook.exe" call terminate

:clear_stored_credentials
for /f "tokens=2 delims= " %%a in ('cmdkey /list ^| findstr /I "LegacyGeneric"') do SET target=%%a
cmdkey /delete:%target% > nul 
if %ERRORLEVEL% EQU 1 goto launch_mypassword_page
if %ERRORLEVEL% EQU 0 goto clear_stored_credentials

:launch_mypassword_page
echo start "" "http://mypassword.pg.com" WAIT > %~dp0\launch_mypassword.cmd
cmd /K launch_mypassword.cmd

:re-sync_windows_password
start cmd /K runas /profile /user:%username%@pg.com cmd