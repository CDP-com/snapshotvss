@echo off
if "%1" == "" goto Usage
vssadmin Resize ShadowStorage /For=%1 /On=%1 /MaxSize=%2GB
REM vssadmin Resize ShadowStorage /For=%1 /On=%1 /MaxSize=%2%%
GOTO End
:Usage
Echo Usage: SetMaxCacheSize {drive letter:} {Size in GB}
Echo For Eample:
Echo SetMaxCacheSize c: 20 (Set Max Cache Size on C volue to 20GB)
:End
Echo Max Cache Size for volume %1 is set to %2GB
pause