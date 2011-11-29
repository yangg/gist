' update svn 1 minute later
WScript.Sleep 60000
Set sh = CreateObject("WScript.Shell")
sh.Run "svn up e:\opt\idkin\oa", 2
' 0 SW_HIDE
' 2 SW_SHOWMINIMIZED
' 3 SW_SHOWMAXIMIZED

' MsgBox "update complete"
