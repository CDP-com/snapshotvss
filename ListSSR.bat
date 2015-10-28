@ECHO OFF 
SET PowerShellScriptPath=%1
powershell -executionPolicy bypass -file "%PowerShellScriptPath%\ListSS_R.ps1" 