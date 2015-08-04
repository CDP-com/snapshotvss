@ECHO OFF 
SET PowerShellScriptPath=%allusersprofile%\cdp\SnapshotsVSS 
powershell -executionPolicy bypass -file "%PowerShellScriptPath%\ListSS_F.ps1" 