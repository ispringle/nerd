(use-package corfu
  :ensure (corfu :files (:defaults "extensions/*")
                 :include (corfu-history
                           corfu-popupinfo))
  :defer 5
  :custom
  (corfu-auto nil)
  (corfu-auto-delay 0.1)
  (corfu-cycle t)
  (corfu-excluded-modes '(erc-mod
                          circe-mode
                          help-mode
                          gud-mode))
  (corfu-separator ?\s)
  (corfu-preview-current 'insert)
  (corfu-on-exact-match nil)
  (corfu-quit-on-boundary nil)
  (corfu-quit-no-match 'separator t)
  :init
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active)
		(bound-and-true-p vertico--input)
		(eq (current-local-map) read-passwd-map))
      ;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
      (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
                  corfu-popupinfo-delay nil)
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)
  (corfu-history-mode)
  (add-to-list 'savehist-additional-variables 'corfu-history)
  (add-hook 'corfu-mode #'corfu-popupinfo-mode)
  (global-corfu-mode))

(use-package corfu-candidate-overlay
  :ensure (:type git
           :repo "https://code.bsdgeek.org/adam/corfu-candidate-overlay"
           :files (:defaults "*.el"))
  :after corfu
  :config
  (corfu-candidate-overlay-mode +1)
  (global-set-key (kbd "S-<tab>") #'corfu-complete))

(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-builtin dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))
