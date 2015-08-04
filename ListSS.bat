@ECHO OFF 
REM SET PowerShellScriptPath=d:\temp 
SET PowerShellScriptPath=%allusersprofile%\cdp\SnapshotsVSS 
powershell -executionPolicy bypass -file "%PowerShellScriptPath%\ListSS.ps1" 
pause