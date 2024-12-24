(use-builtin emacs
             :custom
             ;; Personal details
             (user-full-name "Ian S. Pringle")
             (user-email-address "ian@dapringles.com")
             (auth-sources '("~/.authinfo"))
             
             ;; Completion Stuff
             (text-mode-ispell-word-completion nil) ; Use cape-dict instead
             (completion-cycle-threshold 1)
             (completions-detailed t)
             (tab-always-indent t)
             (completion-auto-help 'always)
             (completions-max-height 20)
             (completions-detailed t)
             (completions-format 'one-column)
             (completions-group t)
             (completion-auto-select 'second-tab)
             (read-extended-command-predicate #'command-completion-default-include-p)
             
             ;; Support opening new minibuffers from inside existing minibuffers.
             (enable-recursive-minibuffers t)
             ;; Hide commands in M-x which do not work in the current mode.  Vertico
             ;; commands are hidden in normal buffers. This setting is useful beyond
             ;; Vertico.
             (read-extended-command-predicate #'command-completion-default-include-p)

             ;; tabbar
             (tab-bar-show 0)
             (display-time-format "%a %F %T")
             (display-time-interval 1)

             ;; Generic system stuff
             (use-dialog-box nil)

             ;;Line numbers
             (line-number-mode t)
             (column-number-mode t)

             ;; Killring stuff
             (save-interprogram-paste-before-kill t)

             ;; pairing
             (electric-pair-pairs '((?\" . ?\")
                                    (?\{ . ?\})))

             (colon-double-space nil)
             (adaptive-fill-mode t)
             :init
             ;; Line numbers
             (column-number-mode)
             (add-hook 'text-mode-hook #'display-line-numbers-mode)
             (add-hook 'prog-mode-hook #'display-line-numbers-mode)
             
             ;; pairing
             (electric-pair-mode 1)

             ;; kill selected region on change
             (delete-selection-mode)

             ;; file stuff
             (global-auto-revert-mode)
             (save-place-mode 1)
             (recentf-mode 1)

             ;; lines and stuff
             (add-hook 'text-mode-hook 'turn-on-auto-fill)
             (setq-default fill-column 80)
             ;; Highlight the current line
             (let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
               (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))
             (set-default 'indent-tabs-mode nil)
             
             ;; Tabbar
             (add-to-list 'tab-bar-format 'tab-bar-format-align-right 'append)
             (add-to-list 'tab-bar-format 'tab-bar-format-global 'append)
             (display-time-mode)
             
             ;; Add prompt indicator to `completing-read-multiple'.
             ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
             (defun crm-indicator (args)
               (cons (format "[CRM%s] %s"
                             (replace-regexp-in-string
                              "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                              crm-separator)
                             (car args))
                     (cdr args)))
             (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

             ;; Do not allow the cursor in the minibuffer prompt
             (setq minibuffer-prompt-properties
                   '(read-only t cursor-intangible t face minibuffer-prompt))
             (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
             :config
             ;; Set font
             (set-face-attribute 'default nil :font "Maple Mono NF CN-12")
             (set-face-attribute 'font-lock-comment-face nil :slant 'italic)

             ;; Disable `<>' pairs in orgmode
             (add-hook 'org-mode-hook (lambda ()
                                        (setq-local electric-pair-inhibit-predicate
                                                    `(lambda (c)
                                                       (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

             (keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete))

