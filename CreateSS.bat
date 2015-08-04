@ECHO OFF 
REM SET PowerShellScriptPath=d:\temp 
SET PowerShellScriptPath=%allusersprofile%\cdp\SnapshotsVSS
powershell.exe -executionPolicy bypass -noexit -file "%PowerShellScriptPath%\CreateSS.ps1" c:\
