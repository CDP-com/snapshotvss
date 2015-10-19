@echo off
if "%1" == "" goto Usage
IF NOT EXIST C:\vss\NUL mkdir c:\vss
SET PowerShellScriptPath=%2
powershell.exe -executionPolicy bypass -file "%PowerShellScriptPath%\mountvss.ps1" %1
pause
goto end
:Usage
echo Usage
echo Mountvss [ALL or Shadow Device ID]
echo.
echo Example:
echo Mountvss.bat ALL
echo Mountvss.bat \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy10 
:end
