(use-package gptel
  :custom
  (gptel-default-mode 'org-mode)
  (gptel-model 'claude-3-sonnet-20240229)
  (gptel-backend (gptel-make-anthropic "Claude"
                   :stream t
                   :key (isp/read-file-contents "~/.config/secrets/anthropic-console"))))

(use-package elysium)
