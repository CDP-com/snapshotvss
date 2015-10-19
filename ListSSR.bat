@ECHO OFF 
REM SET PowerShellScriptPath=d:\temp 
SET PowerShellScriptPath=%1
REM SET PowerShellScriptPath=C:\Users\Public\cdp\SNAPBACK\APPS\SnapshotsVSS 
REM SET PowerShellScriptPath=C:\programdata\cdp\SNAPBACK\APPS\SnapshotsVSS 
powershell -executionPolicy bypass -file "%PowerShellScriptPath%\ListSS_R.ps1" 