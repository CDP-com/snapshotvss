@ECHO OFF 
REM SET PowerShellScriptPath=c:\temp 
SET PowerShellScriptPath=%allusersprofile%\cdp\SnapshotsVSS 
powershell -executionPolicy bypass -file "%PowerShellScriptPath%\ShowSS.ps1" 
pause