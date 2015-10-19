@ECHO OFF 
SET PowerShellScriptPath=%1
regedit /s %PowerShellScriptPath%\MaxShadowCopies.reg
echo "Max Shadow Copies is set to 512"
pause

