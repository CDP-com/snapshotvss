// Use this file to include any custom functions for your app.
 < script language = "jscript" >
var shell = new  ActiveXObject("WScript.Shell")
function createSS()
{
   try
   {
      shell.Run ("%allusersprofile%/cdp/snapshotsvss/CreateSS.lnk", 3, true);
      alert("Create is Successful.");

   }
   catch(e)
   {
      alert ("Create of Shadow Copy Failed");
   }
}
function showSS()
{
   try
   {
      shell.Run ("%allusersprofile%/cdp/snapshotsvss/ShowSS.lnk", 3, true);
      alert("Showing Storage is Successful.");

   }
   catch(e)
   {
      alert ("Showing of Shadow Storage Failed");
   }
}
function listSS()
{
   try
   {
      shell.Run ("%allusersprofile%/cdp/snapshotsvss/ListSS.lnk", 3, true);
      alert("List is Successful.");

   }
   catch(e)
   {
      alert ("List of Shadow Copies Failed");
   }
}
function enableAdmin()
{
   shell.Run ("%allusersprofile%/cdp/snapshotsvss/enable_admin_acc", 3, true);
}

function scheduleSS()
{
   try
   {
      shell.Run ("%allusersprofile%/cdp/snapshotsvss/ScheduleSS.lnk", 3, true);
      alert("Scheduling is Successful.");

   }
   catch(e)
   {
      alert ("Scheduling of Shadow Copies Failed");
   }
}
