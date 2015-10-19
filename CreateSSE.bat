@ECHO OFF 
REM SET PowerShellScriptPath=d:\temp 
REM SET PowerShellScriptPath=C:\Users\Public\cdp\SBSync\APPS\SnapshotsVSS
if "%VssApp_Path%" == "" Set VssApp_Path=C:\programdata\cdp\SNAPBACK\APPS\SnapshotsVSS

REM powershell.exe -executionPolicy bypass  -file "%VssApp_Path%\CreateSS.ps1" %1
powershell.exe -executionPolicy bypass  -file "%~dp0\CreateSS.ps1" %1


