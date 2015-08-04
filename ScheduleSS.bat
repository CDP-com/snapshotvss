@echo off
Set SS_Batch=%allusersprofile%\cdp\SnapshotsVSS\CreateSS.bat

REM SCHTASKS /Create /SC DAILY /TN CreateSS /TR %allusersprofile%\cdp\SnapshotsVSS\CreateSS.bat" "c:\ /ST 12:00 
SCHTASKS /Create /SC DAILY /TN CreateSS /TR %SS_Batch%" "c:\ /ST 12:00 /RL HIGHEST