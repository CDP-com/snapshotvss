param([string]$ShadowDevID = "", 
      [string]$MountDir = "")

Function MountVSS {
Begin { 
    Try {
        $null = [mklink.symlink]
    } Catch {
        Add-Type @"
        using System;
        using System.Runtime.InteropServices;
  
        namespace mklink
        {
            public class symlink
            {
                [DllImport("kernel32.dll")]
                public static extern bool CreateSymbolicLink(string lpSymlinkFileName, string lpTargetFileName, int dwFlags);
            }
        }
"@
    }
}
Process {
    $ShadowDevID | ForEach-Object -Process {
        if ($($_).EndsWith("\")) {
            $sPath = $_
        } else {
            $sPath = "$($_)\"
        }

        Get-WmiObject Win32_Shadowcopy | ForEach-Object { 
            $strDeviceObject = $_.DeviceObject
            $WmiSnapShotDate = $_.InstallDate             
            $dtmSnapShotDate = [management.managementDateTimeConverter]::ToDateTime($WmiSnapShotDate)
            $DateStr = ($dtmSnapShotDate).ToString("yyyy.MM.dd-HH.mm.ss")
            if([string]::IsNullOrEmpty($MountDir)) {
                $MountDir="c:\vss"
            }
            
            if ($ShadowDevID -eq "ALL") {
                $sPath = "$strDeviceObject\"
                $tPath = Join-Path -Path $MountDir -ChildPath ((Split-Path -Path $sPath -Leaf))
                $tPath=$tPath+"{"+$DateStr+"}"         

                try {
                    if ( [mklink.symlink]::CreateSymbolicLink($tPath,$sPath,1)) {
                        echo "Successfully mounted $sPath to $tPath"
                    } else  {
                        echo "Failed to mount $sPath"
                    }
                } catch {           
                    echo "Failed to mount $sPath because $($_.Exception.Message)"
                }                 

            } else {
                if ($ShadowDevID -eq $strDeviceObject) {
                    $tPath = Join-Path -Path $MountDir -ChildPath ((Split-Path -Path $sPath -Leaf))
                    $tPath=$tPath+"{"+$DateStr+"}"         

                    try {
                        if ( [mklink.symlink]::CreateSymbolicLink($tPath,$sPath,1)) {
                            echo "Successfully mounted $sPath to $tPath"
                        } else  {
                            echo "Failed to mount $sPath"
                        }
                    } catch {           
                        echo "Failed to mount $sPath because $($_.Exception.Message)"
                    }                 
                }
            }
        }


         

    }
 
}
End {}
}
 

MountVSS