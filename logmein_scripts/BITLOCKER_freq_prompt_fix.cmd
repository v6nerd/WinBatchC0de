@echo on
mode con:cols=90 lines=35

REM ===========================================================
REM Description: Fix Bitlocker Frequent prompts
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ===========================================================

:add_resume_script
(
echo manage-bde -protectors -enable %homedrive%
echo shutdown /r /t 60
)> %~dp0\fix_bitlocker.cmd
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v %~n0 /d %~dpnx0 /f

:disable_bitlocker
manage-bde -protectors -disable %homedrive%
shutdown /r /t 60