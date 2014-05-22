@echo off
mode con:cols=90 lines=35

REM ===========================================================
REM Description: MSLYNC 2010 is not starting FIX (Multiple Instances Issue)
REM Type: BatchScript
REM Version: 1.0 REV 13
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ===========================================================

REM Fixes MSLYNC 2010 Multiple Instances

wmic process where name="communicator.exe" call terminate
wmic process where name="UcMapi.exe" call terminate