@ echo on
:launch_mypassword_page
start "" "http://mypassword.pg.com" WAIT
wmic logicaldisk where description="Network Drive" get name > %~dp0\net_drives.txt
for /f "tokens=* skip=1 delims=:" %%a in ('type ~%dp0\net_drives.txt') DO set drive=%%a
IF %ERRORLEVEL% EQU 0 net use /delete %drive% 
IF %ERRORLEVEL% EQU 1 echo done!