var shell  = new ActiveXObject("WScript.Shell");
var Win32_ShadowCopy = GetObject("winmgmts:\\\\.\\root\\cimv2:Win32_ShadowCopy");

var intRC = Win32_ShadowCopy.Create("C:\\", "ClientAccessible");

if  (intRC == 0) {
     WScript.Echo ("Snapshot is created. ");
} else {
     WScript.Echo ("Failed");
};
