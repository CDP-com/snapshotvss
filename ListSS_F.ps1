
Function ListSnapshot()
{ 
    $Counter = 0  

    Get-WmiObject Win32_Shadowcopy | ForEach-Object { 
        $strShadowID = $_.ID 
        $strClientAccessible = $_.ClientAccessible
        $WmiSnapShotDate = $_.InstallDate
        $dtmSnapShotDate = [management.managementDateTimeConverter]::ToDateTime($WmiSnapShotDate)
		$DateStr = ($dtmSnapShotDate.ToUniversalTime()).ToString("yyyy.MM.dd-HH.mm.ss")
		$GMTDateStr = "\\127.0.0.1\C$\@GMT-" + $DateStr + ","
        if ($Counter -eq 0) {
            echo "            Snapshot ID                         Time           Hidden"
            echo "--------------------------------------   -------------------   ------"
        }
        if ($strClientAccessible -eq "True") {
            echo "$strShadowID : $dtmSnapShotDate     No"          
        } else {
            echo "$strShadowID : $dtmSnapShotDate     Yes"
        }       
        # $strShadowID | out-file -filepath d:\temp\ss_id.txt -append
        # $strShadowID,$dtmSnapShotDate | out-file -filepath .\ss_id.txt -append
        # $strShadowID | out-file -filepath .\ss_id.txt -append
        $GMTDateStr | out-file -filepath .\ss_id.txt -append
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
