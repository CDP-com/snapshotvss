
Function ListSnapshot()
{ 
    $Counter = 0  

    Get-WmiObject Win32_Shadowcopy | ForEach-Object { 

        $strShadowID = $_.Name
        $strClientAccessible = $_.ClientAccessible
        $WmiSnapShotDate = $_.InstallDate
        $setID = $_.SetID

        $dtmSnapShotDate = [management.managementDateTimeConverter]::ToDateTime($WmiSnapShotDate)
		
        if ($Counter -eq 0) {
            echo "            Snapshot ID                         Time           Hidden"
            echo "--------------------------------------   -------------------   ------"
        }
							
        if ($strClientAccessible -eq "True") {
            echo "$strShadowID : $dtmSnapShotDate     No	$setID"
        } else {
            echo "$strShadowID : $dtmSnapShotDate     Yes	$setID"
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
