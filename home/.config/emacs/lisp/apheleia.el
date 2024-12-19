(use-package apheleia
  :defer t
  :custom
  (apheleia-mode-lighter nil)
  (js-indent-level 2)
  (standard-indent 2)
  :config
  ;; (require apheleia-formatters)
  ;; (dolist (formatter-cmds '((eslint . (npx "eslint" "--fix-to-stdout" "--stdin" "--stdin-filename" file))))
  ;;   (add-to-list #'apheleia-formatters formatter-cmds))
  ;;       (dolist (formatter-modes '((typescript-mode . apheleia-js-formatter)
  ;;                              (javascript-mode . apheleia-js-formatter)
  ;;                              (javascript-ts-mode . apheleia-js-formatter)
  ;;                              (typescript-ts-mode . apheleia-js-formatter)))
  ;;     (add-to-list #'apheleia-mode-alist formatter-modes))
  :init
  (apheleia-global-mode)
  ;; (defvar apheleia-js-formatter 'prettier)
  ;; (defun apheleia-toggle-js-formatter ()
  ;;   (interactive)
  ;;   (if (equal apheleia-js-formatter 'prettier)
  ;;       (setq apheleia-js-formatter 'eslint)
  ;;     (setq apheleia-js-formatter 'prettier))
  ;;   (dolist (formatter-modes '((typescript-mode . apheleia-js-formatter)
  ;;                              (javascript-mode . apheleia-js-formatter)
  ;;                              (javascript-ts-mode . apheleia-js-formatter)
  ;;                              (typescript-ts-mode . apheleia-js-formatter)))
  ;;     (add-to-list #'apheleia-mode-alist formatter-modes)))
  :general
  ("C-c f" 'apheleia-format-buffer))
  
