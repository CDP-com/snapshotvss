@ECHO OFF 
SET PowerShellScriptPath=%1
powershell -executionPolicy bypass -file "%PowerShellScriptPath%\ShowSS.ps1" 
pause