takeown /f "%1" & icacls "%1" /grant administrators:F

;; add Environment
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Environment" /v VIMBIN /t REG_SZ /d "%%USERPROFILE%%/.vim/vimbin"

;; Using batch parameters
;; http://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/percent.mspx?mfr=true
%cd%
Modifier	Description
%~1         Expands %1 and removes any surrounding quotation marks ("").
%~f1        Expands %1 to a fully qualified path name.
%~d1        Expands %1 to a drive letter.
%~p1        Expands %1 to a path.
%~n1        Expands %1 to a file name.
%~x1        Expands %1 to a file extension.
%~s1        Expanded path contains short names only.
%~a1        Expands %1 to file attributes.
%~t1        Expands %1 to date and time of file.
%~z1        Expands %1 to size of file.
%~$PATH:1   Searches the directories listed in the PATH environment variable and expands %1 to the fully qualified name of the first one found. If the environment variable name is not defined or the file is not found, this modifier expands to the empty string.
;; possible combinations of modifiers and qualifiers
%~dp1                Expands %1 to a drive letter and path.
%~nx1                Expands %1 to a file name and extension.
%~dp$PATH:1          Searches the directories listed in the PATH environment variable for %1 and expands to the drive letter and path of the first one found.
%~ftza1              Expands %1 to a dir-like output line.
