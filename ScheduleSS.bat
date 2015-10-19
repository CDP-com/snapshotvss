@echo off
REM Set SS_Batch=C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat
REM Set VssApp_Path=C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\SnapshotsVSS

REM SCHTASKS /Create /SC DAILY /TN CreateSS /TR C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat" "c:\ /ST 12:00 
REM SCHTASKS /Create /SC DAILY /TN CreateSS /TR %%VssApp_Path%%\test.bat" "c:\ /ST 12:00 /RL HIGHEST
REM -------------------------------------------------------------------------------------------

REM Set SS_Batch=C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat

if "%1" == "Prod" (
    Set VssApp_Path=C:\ProgramData\CDP\SnapBack\APPs\snapshotsvss
    goto Continue
)
if "%1" == "Dev"  (
    Set VssApp_Path=C:\Users\Public\cdp\SNAPBACK\APPS\SnapshotsVSS
    goto Continue
 )
if "%1" == "Test" (
    Set VssApp_Path=C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS
    goto Continue
)

IF EXIST C:\ProgramData\CDP\SnapBack\APPs\snapshotsvss\NUL (
    Set VssApp_Path=C:\ProgramData\CDP\SnapBack\APPs\snapshotsvss
    goto Continue
)
IF EXIST C:\Users\Public\cdp\SNAPBACK\APPS\SnapshotsVSS\NUL (
    Set VssApp_Path=C:\Users\Public\cdp\SNAPBACK\APPS\SnapshotsVSS
    goto Continue
)
IF EXIST C:\Users\Public\cdp\SBSync\APPS\SnapshotsVSS\NUL (
    Set VssApp_Path=C:\Users\Public\cdp\SBSync\APPS\SnapshotsVSS
    goto Continue
)
:Continue
if "%VssApp_Path%" == "" (
    echo No Valid Path Found
    goto End
)

echo %VssApp_Path%
REM SCHTASKS /Create /SC DAILY /TN CreateSS /TR C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat" "c:\ /ST 12:00 
SCHTASKS /Create /SC DAILY /TN CreateSS /TR %VssApp_Path%\CreateSSE.bat" "c:\ /ST 12:00 /RL HIGHEST

:End