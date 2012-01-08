(add-hook 'shell-mode-hook
          '(lambda()
             (local-set-key '[up] 'comint-previous-input)
             (local-set-key '[down] 'comint-next-input)))
