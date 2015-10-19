@ECHO OFF 
SET PowerShellScriptPath=%1
powershell -executionPolicy bypass -file "%PowerShellScriptPath%\ListSS.ps1" 
pause

