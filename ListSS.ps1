
Function ListSnapshot()
{ 
    $Counter = 0  

    Get-WmiObject Win32_Shadowcopy | ForEach-Object { 
        $strShadowID = $_.ID 
        $strClientAccessible = $_.ClientAccessible
        $WmiSnapShotDate = $_.InstallDate
        $dtmSnapShotDate = [management.managementDateTimeConverter]::ToDateTime($WmiSnapShotDate)
        if ($Counter -eq 0) {
            echo "            Snapshot ID                         Time           Hidden"
            echo "--------------------------------------   -------------------   ------"
        }
        if ($strClientAccessible -eq "True") {
            echo "$strShadowID : $dtmSnapShotDate     No"
        } else {
            echo "$strShadowID : $dtmSnapShotDate     Yes"
        }
        $Counter++ 
    } 
    if ($Counter -eq 0) {
        echo "No Snapshots."
    } else {
        echo " "
        echo "Total Snapshots : $Counter"
    }
}

ListSnapshot([string[]]$args)
