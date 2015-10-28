// JavaScript  
//
// 10-06-15  - Kai  -  Set the size of the cache file based on following logic
// 			---   Max cache space - minus cache used = x 
//			---			IF x < 10 GB then 
//			---			IF (USED space < 60 ) HD space - Minus Used (uses Win API to get free space) < 60 GB THEN
//			---				ADD +20 GB to MAX cache size
//  PLEASE put changes or additions below
// 10-20-15 --- Kai   ---- Call Vssadmin directly so we don't need to worry about path.
//
//  
var shell  = new ActiveXObject("WScript.Shell");
var objWMIService = GetObject("winmgmts:\\\\.\\root\\CIMV2");



var VolcolItems = objWMIService.ExecQuery("select * from win32_volume");
var SScolItems = objWMIService.ExecQuery("select * from Win32_ShadowStorage");
var nVssIndex = 0;
var nCount = 0;

var VolenumItems = new Enumerator(VolcolItems);
for (; !VolenumItems.atEnd(); VolenumItems.moveNext()) 
{
   var VolobjItem = VolenumItems.item();
   var strDriveLetter = VolobjItem.DriveLetter;
   var intDriveType = VolobjItem.DriveType ;
   var FreeSpace = VolobjItem.FreeSpace/1073741824;
   var strRELPATH = VolobjItem.DeviceID;  
   var strDeviceID = strRELPATH.substr(11, 36);

   if (intDriveType == 3  && strDriveLetter == "C:") 
   {
       var SSenumItems = new Enumerator(SScolItems);
       for (; !SSenumItems.atEnd(); SSenumItems.moveNext()) 
       {
           var SSobjItem = SSenumItems.item();
           var strVolume = SSobjItem.Volume;
           var strVolumeID = strVolume.substr(37, 36);
           var MaxCache = SSobjItem.MaxSpace/1073741824;
           var UsedCache = SSobjItem.UsedSpace/1073741824;
           if (strDeviceID == strVolumeID)
           {
               if ((MaxCache - UsedCache) < 10 && FreeSpace > 60)
               {
                   
                   MaxCache += 20;  
                   WScript.Echo("Reset Max Cache to " + MaxCache);
                   strCmd = "vssadmin Resize ShadowStorage /For=" + strDriveLetter + " /On=" + strDriveLetter + " /MaxSize=" + MaxCache +"GB"
                                      
                   shell.Run (strCmd,1,true);  
                    
               } 
           }

       }
    }

}



