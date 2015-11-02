@echo off
REM Set SS_Batch=C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat
REM Set VssApp_Path=C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\SnapshotsVSS

REM SCHTASKS /Create /SC DAILY /TN CreateSS /TR C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat" "c:\ /ST 12:00 
REM SCHTASKS /Create /SC DAILY /TN CreateSS /TR %%VssApp_Path%%\test.bat" "c:\ /ST 12:00 /RL HIGHEST
REM -------------------------------------------------------------------------------------------

REM Set SS_Batch=C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat


    Set VssApp_Path=%1
    goto Continue)
:Continue
if "%VssApp_Path%" == "" (
    echo No Valid Path Found
    goto End
)

echo %VssApp_Path%
REM SCHTASKS /Create /SC DAILY /TN CreateSS /TR C:\Users\Public\CDP\SBSync\APPs\SnapshotsVSS\CreateSSE.bat" "c:\ /ST 12:00 
SCHTASKS /Create /SC DAILY /TN CreateSS /TR %VssApp_Path%\CreateSSE.bat" "c:\ /ST 12:00 /RL HIGHEST
echo Your schedule is set to run at 12:00pm every day.
pause
:End