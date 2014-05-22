@echo off
REM ==============================================================
REM Description: Checks AvayaVPN Services Issues
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ==============================================================

REM == Check VPN services ==

:chk_vpn_svc
sc query BFE | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 goto BFE_launch
if %ERRORLEVEL% EQU 0 goto chk_IKEEXT
:BFE_launch
echo Trying to start The Base Filtering Engine (BFE) ... wait!
sc start BFE > nul
if %ERRORLEVEL% EQU 1060 echo. & echo ^<^< Trying to FiXBFE ^>^> & goto fix_bfe
timeout /T 15 > nul
sc query BFE | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 echo & echo ^<^< Trying to FiXBFE ^>^> & goto fix_bfe
if %ERRORLEVEL% EQU 0 goto chk_IKEEXT
:chk_IKEEXT
sc query IKEEXT | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 goto IKEEXT_launch
if %ERRORLEVEL% EQU 0 goto chk_NvCSvc
:IKEEXT_launch
sc start IKEEXT
if %ERRORLEVEL% EQU 1060 echo. & echo ^<^< Trying to FiXBFE ^>^> & goto fix_bfe
if %ERRORLEVEL% EQU 0 goto chk_NvcSvc
timeout /T 15 > nul
sc query IKEEXT | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 0 goto chk_NvcSvc
if %ERRORLEVEL% EQU 1 echo & echo. ^<^< Trying to FiXBFE ^>^> & goto fix_bfe
:chk_NvcSvc
sc query NvcSvcMgr | FIND "STATE" | FIND "RUNNING" > nul
if %ERRORLEVEL% EQU 1 goto NvcSvc_launch
if %ERRORLEVEL% EQU 0 echo. & echo ^[ == Avaya VPN 10 Services are Running properly == ^] & exit
:NvcSvC_launch
sc start NvcSvcMgr > nul
if %ERRORLEVEL% EQU 1060 echo. & echo  ^<^< Avaya VPN 10 is not Installed Please re-install. ^>^> & exit