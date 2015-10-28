REM  10/27/2015  --Kai--   Now, we keep prvious report and append number to the end of the name of previous report



@echo off
setlocal enabledelayedexpansion
set /A Counter=1
cd %1

if exist ss_report.txt (
    REM echo ss_report_%Counter%.txt
:Label1
    if exist ss_report_%Counter%.txt ( 
        set /A Counter+=1
        goto Label1
     ) else (
        REM echo ss_report_%Counter%.txt
        rename ss_report.txt ss_report_%Counter%.txt
     )
)
echo Generating Report....
echo | listssr.bat %1
echo ----------------------------------vssadmin list shadowstorage----------------------------------------- >> ss_report.txt
vssadmin list shadowstorage >> ss_report.txt
echo -------------------------------------vssadmin list shadows-------------------------------------------- >> ss_report.txt
vssadmin list shadows >> ss_report.txt
echo ------------------------------------vssadmin list providers------------------------------------------- >> ss_report.txt
vssadmin list providers >> ss_report.txt
echo -------------------------------------vssadmin list volumes-------------------------------------------- >> ss_report.txt
vssadmin list volumes >> ss_report.txt
echo -------------------------------------vssadmin list writers-------------------------------------------- >> ss_report.txt
vssadmin list writers >> ss_report.txt

Notepad.exe %1\ss_report.txt
REM Notepad.exe c:\users\public\cdp\snapback\apps\snapshotsvss\ss_report.txt
REM Notepad.exe c:\programdata\cdp\snapback\apps\snapshotsvss\ss_report.txt

