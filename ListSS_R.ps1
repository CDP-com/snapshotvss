function Print-Header{
    $ServerName=$env:computername
    $LocTime = Get-Date
    $UtcTime = $LocTime.ToUniversalTime()
    echo "Snapshot Report For : $ServerName    Local=$LocTime    UTC=$UtcTime" | out-file -filepath .\ss_report.txt -encoding ASCII -append
    echo "" | out-file -filepath .\ss_report.txt -encoding ASCII -append

}

function Get-Drives-Info {  
    Get-WmiObject -Class win32_volume | ForEach-Object { 
        $intDriveType=$_.DriveType 
        $strDeviceID=$_.DeviceID 
        $strDriveLetter = $_.DriveLetter
        $strRELPATH = $_.__RELPATH
        $strCapacity=$_.Capacity/1073741824 
        $strFreeSpace=$_.FreeSpace/1073741824 
        $strUsedSpace=$strCapacity-$strFreeSpace
        $strCapacity="{0:N2}" -f $strCapacity 
        $strFreeSpace="{0:N2}" -f $strFreeSpace 
        $strUsedSpace="{0:N2}" -f $strUsedSpace 
        $strPerFree = "{0:P2}" -f ($strFreeSpace/$strCapacity)
        $strPerUsed = "{0:P2}" -f ($strUsedSpace/$strCapacity)
               
        if ($intDriveType -eq 3 -And $strDriveLetter) {
            Get-WmiObject Win32_ShadowStorage | ForEach-Object { 
                $strVolume = $_.Volume
                if ($strRELPATH -eq $strVolume) {
                    $strMaxSpace = $_.MaxSpace/1073741824
                    $strAllocatedSpace = $_.AllocatedSpace/1073741824
                    $strCacheUsedSpace = $_.UsedSpace/1073741824
                    $strMaxSpace = "{0:N2}" -f $strMaxSpace
                    $strAllocatedSpace = "{0:N2}" -f $strAllocatedSpace
                    $strCacheUsedSpace = "{0:N2}" -f $strCacheUsedSpace
                    $strPerMaxSpace = "{0:P2}" -f ($strMaxSpace/$strCapacity)
                    $strPerAllocatedSpace = "{0:P2}" -f ($strAllocatedSpace/$strCapacity)
                    $strPerUsedSpace = "{0:P2}" -f ($strCacheUsedSpace/$strCapacity)

                    echo "Vol $strDriveLetter=$strCapacity GB(100 %)  Free Space=$strFreeSpace GB($strPerFree)  Used Space=$strUsedSpace GB($strPerUsed)  OS version : $strOsVersion"  | out-file -filepath .\ss_report.txt -encoding ASCII -append   
                    echo "       Max Cache Space=$strMaxSpace GB($strPerMaxSpace)   Allocated Cache Space=$strAllocatedSpace GB($strPerAllocatedSpace)    Used Cache Space=$strCacheUsedSpace GB($strPerUsedSpace)" | out-file -filepath .\ss_report.txt -encoding ASCII -append   
                }
            }

        }
    }   
}  

function Get-Drives {  
    param(  
    $strVolID
    )  
    Get-WmiObject -Class win32_volume | ForEach-Object {  
        $strDeviceID=$_.DeviceID 
        $strDriveLetter =   $_.DriveLetter
        $strCapacity=$_.Capacity
        $strFreeSpace=$_.FreeSpace

        if ($strDeviceID -eq $strVolID) {
            echo "($strDriveLetter)$strDeviceID" | out-file -filepath .\ss_report.txt -encoding ASCII -append        
        }
    }      
}  

Function ListSnapshot()
{ 
    $Counter = 0  
    $VolPrn = 0
    

    #$CurDate = get-date 
    #$CurDate = get-date -displayhint date -format "MM/dd/yyyy hh:mm:ss"   

    echo "-----------------------------------------------------------------------------------------------------------------------------------" | out-file -filepath .\ss_report.txt -encoding ASCII -append

    Get-WmiObject Win32_Shadowcopy | ForEach-Object { 
        $strShadowID = $_.ID         
        $strCurVolumeName = $_.VolumeName
        $strDeviceObject = $_.DeviceObject
        $strVssNumber = $strDeviceObject.Substring(46)
        $strVssNumber = "{0:N3}" -f $strVssNumber 
        $strClientAccessible = $_.ClientAccessible
        $strNoWriters = $_.NoWriters
        $WmiSnapShotDate = $_.InstallDate
        $dtmSnapShotDate = [management.managementDateTimeConverter]::ToDateTime($WmiSnapShotDate)
	$DateStr = ($dtmSnapShotDate.ToUniversalTime()).ToString("yyyy.MM.dd-HH.mm.ss")
        $DateStr1 = ($dtmSnapShotDate.ToUniversalTime()).ToString("yyyy.MM.dd HH.mm.ss")
        $GMTDateStr = "S:\@GMT-" + $DateStr

        if ($Counter -eq 0 -Or $strVolumeName -ne $strCurVolumeName) {
            $strVolumeName = $_.VolumeName
            if ($Counter -ne 0) {
                echo "Total Snapshots : $Counter" | out-file -filepath .\ss_report.txt -encoding ASCII -append
                echo "------------------------------------------------------------------------------------------------------------------------------" | out-file -filepath .\ss_report.txt -encoding ASCII -append
                echo " " | out-file -filepath .\ss_report.txt -encoding ASCII -append
                $Counter=0
            }
            Get-Drives $strVolumeName 
            echo " " | out-file -filepath .\ss_report.txt -encoding ASCII -append
            echo " Mountable?      Date     Local      UTC Date  UTC Time      Use to mount=When S:\ is a network share of c:\ then mount:   ID " | out-file -filepath .\ss_report.txt -encoding ASCII -append
            echo "------------  ---------- --------   ---------- --------      -----------------------------------------------------------  ----" | out-file -filepath .\ss_report.txt -encoding ASCII -append
        }
        if ($strClientAccessible -eq "True" -And $strNoWriters -eq "False") {
            #echo "$strShadowID : $dtmSnapShotDate     Yes"   
            echo "    Yes       $dtmSnapShotDate   $DateStr1      Use to mount = $GMTDateStr                    $strVssNumber"    | out-file -filepath .\ss_report.txt -encoding ASCII -append      
        } else {
            #echo "$strShadowID : $dtmSnapShotDate     No"
            echo "    No        $dtmSnapShotDate   $DateStr1      Use to mount = $GMTDateStr                    $strVssNumber"   | out-file -filepath .\ss_report.txt -encoding ASCII -append
        }       
        $Counter++ 
    } 
    if ($Counter -eq 0) {
        echo "No Snapshots." | out-file -filepath .\ss_report.txt -encoding ASCII -append
    } else {
        echo "Total Snapshots : $Counter" | out-file -filepath .\ss_report.txt -encoding ASCII -append
    }
    echo "------------------------------------------------------------------------------------------------------------------------------" | out-file -filepath .\ss_report.txt -encoding ASCII -append
}

$strOsVersion=(Get-WmiObject -class Win32_OperatingSystem).Caption
Print-Header
Get-Drives-info 
ListSnapshot([string[]]$args)
