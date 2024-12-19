(use-package expand-region
  :commands expand-region
  :general
  ("C-," 'er/expand-region)
  :config
  (add-to-list 'expand-region-exclude-text-mode-expansions 'org-mode)
  (set-default 'er--show-expansion-message nil)
  (setq expand-region-show-usage-message nil
        expand-region-fast-keys-enabled nil)
  (defvar expand-region-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "," #'er/expand-region)
      (define-key map "." #'er/contract-region)
      (dotimes (i 10)
        (define-key map
                    (kbd (number-to-string i))
                    (lambda ()
                      (interactive)
                      (er/expand-region i)
                      (setq this-command 'er/expand-region))))
      map))
  (put 'er/expand-region 'repeat-map 'expand-region-repeat-map)
  (put 'er/contract-region 'repeat-map 'expand-region-repeat-map)
  (advice-add 'er--first-invocation
              :override
              (defun fv--er--first-invocation ()
                "true if this is the first invocation of er/expand-region or er/contract-region"
                (not (memq last-command
                           '(er/expand-region
                             er/contract-region
                             easy-kill-expand-region
                             easy-kill-contract-region))))))
