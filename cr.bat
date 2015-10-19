@echo off
cd %1

if exist ss_report.txt del ss_report.txt
echo Generating Report....
echo | listssr.bat
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

