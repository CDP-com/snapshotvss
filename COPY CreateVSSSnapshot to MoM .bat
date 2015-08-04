Echo off
Set SrcPath=%allusersprofile%\cdp\SnapshotsVSS\
REM Set DesPath=%AppData%\cdp\oom\mymenu\ 
Set DesPath=%UserProfile%\AppData\Roaming\cdp\oom\mymenu\

echo '
echo '
Echo This copies the shortcut SnapshotsVss-Admin to the MoM Menu -- 
Echo You still need to add it to MoM from the ADD menu, after a scan.  Hit Enter to continue 
Echo '
Pause
REM Copy %LnkFilePath% /V %DesPath%
Set CpCmd=Copy /V "%SrcPath%SnapshotsVss-Admin.lnk" "%DesPath%"
Echo %CpCmd%

%CpCmd%
if %errorlevel% == 0 (
    Echo Copy Success! File Copied to %DesPath%
) else (
    Echo Copy Failed
)

REM Echo Source:
REM Dir  %SrcPath%
REM Echo Destination:
REM DIR  %DesPath%
REM Echo '
REM Echo  DONE!!  -- Check the date above, and they should match,  Now, add this to your MoM page.
REM Echo '
Pause