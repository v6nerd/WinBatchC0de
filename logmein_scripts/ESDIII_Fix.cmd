@echo on
mode con:cols=90 lines=35

REM ===================================================
REM Description: ESDIII fix (32 /64 bit)
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ===================================================

:run_ESDIII_Fix
unzip -q -o ESDIII_Fix.zip
wscript c:\RepairSubSvcSEWPnW7.vbs