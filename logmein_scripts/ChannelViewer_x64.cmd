@echo on
mode con:cols=90 lines=35

REM ===================================================
REM Description: Channel Viewer Repair x64
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ===================================================

:run_ChannelViewer_Repair
unzip -q -o RepairEsupportx64.zip
wscript c:\RepairEsupport64.vbs