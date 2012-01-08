;; difference between two ways to defalias
(defalias 'backward-delete-char 'delete-backward-char)
(defalias 'search-forward-regexp (symbol-function 're-search-forward))
;; http://stackoverflow.com/questions/1545993/difference-between-defalias-a-symbol-function-b-and-defalias-a-b
