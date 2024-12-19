(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("M-." . embark-dwim)
   ("C-h B" . embark-bindings))
  :custom
  (prefix-help-command #'embark-prefix-help-command)
  :init
  (add-hook 'eldoc-documentation-function #'embark-eldoc-first-target)
  (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)
  :config
  (add-to-list 'display-buffer-alist
               '("\\'\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  (with-eval-after-load 'eat
    (define-key shell-mode-map [remap display-local-help] #'man))
  (with-eval-after-load 'sly
    (let ((map sly-editing-mode-map))
      (define-key map [remap display-local-help] #'sly-describe-symbol)
      (define-key map [remap embark-pp-eval-defun] #'sly-compile-defun)
      (define-key map [remap pp-macroexpand-expression] #'sly-expand-1)
      (define-key map [remap pp-eval-expression] #'sly-interactive-eval)
      (define-key map [remap xref-find-definitions] #'sly-edit-definition)))
  (add-hook 'embark-collect-post-revert-hook
            (defun resize-embark-collect-window (&rest _)
              (when (memq embark-collect--kind '(:live :completions))
                (fit-window-to-buffer (get-buffer-window)
                                      (floor (frame-height) 2) 1)))))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))
