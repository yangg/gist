#!/bin/bash
# Argument: filename to open in new Emacs frame
/usr/bin/emacsclient -e '(let ((default-directory "`pwd`/")) (select-frame (make-frame)) (find-file "'$1'"))'
