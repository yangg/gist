(directory-files lisp-path)
(following-char) (preceding-char)
(char-after)
(skip-chars-forward)

(bury-buffer)
(browser-url)

emacs -batch -f batch-byte-compile thefile.el

;; Compile your .emacs
(defun autocompile nil
  "compile itself if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (let ((dotemacs (expand-file-name "~/.emacs")))
    (if (string= (buffer-file-name) (file-chase-links dotemacs))
      (byte-compile-file dotemacs))))
(add-hook 'after-save-hook 'autocompile)

;; Compile2
(require 'bytecomp)
(setq compiled-init-file (byte-compile-dest-file user-init-file))
(if (or (not (file-exists-p compiled-init-file))
        (file-newer-than-file-p user-init-file compiled-init-file)
        (equal (nth 4 (file-attributes user-init-file)) (list 0 0)))
    (load user-init-file)
  (load compiled-init-file))
(add-hook 'kill-emacs-hook
          '(lambda ()
             (if (file-newer-than-file-p user-init-file compiled-init-file)
                           (byte-compile-file user-init-file))))

;; http://www.emacswiki.org/emacs/OptimizingEmacsStartup
;; autoload & eval-after-load

;; (eq system-type "gnu/linux")
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(global-set-key [f11] 'my-fullscreen)

