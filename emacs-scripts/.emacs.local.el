;;-*-mode: emacs-lisp;-*-

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

(add-to-list 'directory-abbrev-alist '("^/shortname" . "/ssh:username@host:dir"))

;; set default browser
;; (browse-url)
;; (browse-url-of-buffer)
;; (browse-url-emacs)
(setq browse-url-generic-program "x-www-browser"
      browse-url-browser-function 'browse-url-generic)
      ;;(substring (shell-command-to-string "gconftool-2 -g /desktop/gnome/applications/browser/exec") 0 -1)

(setq tags-file-name "~/Project/TAGS")
;; M-.      find-tag
;; C-u M-.  universal-argument, find next tag
;; M-*      pop-tag-mark, pop back to where M-. was last invoked
;; M-TAB    complete-symbol

(defun my-php-symbol-lookup ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
        (message "No symbol at point.")
      (browse-url (concat "http://php.net/manual-lookup.php?pattern="
                          (symbol-name symbol))))))

(defun set-mode ()
  "set multi-mode"
  (interactive)
  (save-excursion
    (if (re-search-backward "</script>\\|\\?>\\|</style>\\|<script[^>]*>\\|<\\?\\|<style[^>]*>\\|<\sw+[^>]*>\\(['\"]?\\)" nil t)
        (let ((res (match-string 0))
              (new-mode nil))
          (cond ((equal res "<?") (setq new-mode 'php-mode))
                ((string-match "^<script" res) (setq new-mode 'js-mode))
                ((string-match "^<style" res) (setq new-mode 'css-mode))
                (t (setq new-mode 'html-mode)))
          (and (eq new-mode 'html-mode)
               (> (length (match-string 1)) 0)
               (setq new-mode 'js-mode))
          (or (eq new-mode major-mode)
              (funcall new-mode))))))
(defun php-newline ()
  (interactive)
  (if (string-match "views\\(/[a-zA-Z0-9_]+\\)+\\.php$\\|\\.[sp]?html$" buffer-file-truename)
      (set-mode))
  (newline-and-indent))
(global-set-key (kbd "RET") 'php-newline)
(add-hook 'php-mode-hook
          '(lambda ()
             (local-set-key (kbd "<f1>") 'my-php-symbol-lookup)
             (setq php-warned-bad-indent t)))
