(use-package gptel
  :defer t
  :commands (gptel gptel-menu gptel-send gptel-request)
  :config
  (setq gptel-default-mode 'org-mode)
  (setq gptel-model 'claude-3-sonnet-20240229)
  (setq gptel-backend (gptel-make-anthropic "Claude"
                        :stream t
                        :key (isp/read-file-contents "~/.config/secrets/anthropic-console"))))

(use-package elysium
  :after 'gptel)
