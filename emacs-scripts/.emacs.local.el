(desktop-save-mode t)
(setq desktop-load-locked-desktop nil)
(add-hook 'desktop-not-loaded-hook 'desktop-save-mode-off)

;; http://edward.oconnor.cx/config/.emacs
(setq auto-mode-case-fold t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(add-hook 'before-save-hook 'time-stamp)
;; time-stamp-pattern: "4/Last Modified: %3b %:d, %:y\n"

(setq mouse-buffer-menu-mode-mult 1)

(setq-default abbrev-mode t)
(when (file-exists-p abbrev-file-name)
  (quietly-read-abbrev-file))

;; set default browser
;; (browse-url)
;; (browse-url-of-buffer)
(setq browse-url-generic-program "x-www-browser"
      ;;(substring (shell-command-to-string "gconftool-2 -g /desktop/gnome/applications/browser/exec") 0 -1)
      browse-url-browser-function 'browse-url-generic)
