;; http://www.emacswiki.org/emacs/CustomizeAquamacs
(when (featurep 'aquamacs)
  ;; transparency
  (setq transparency-level 80)
  (set-frame-parameter nil 'alpha transparency-level)
  (add-hook 'after-make-frame-functions
            (lambda (selected-frame)
              (set-frame-parameter selected-frame 'alpha transparency-level)))
  ;; switch to fullscreen mode
  ;; (aquamacs-toggle-full-frame)
  (setq inhibit-startup-echo-area-message t))
