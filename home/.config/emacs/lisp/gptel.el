(use-package gptel
  :custom
  (gptel-model 'claude-3-sonnet-20240229)
  :config
  (gptel-make-anthropic "Claude"
                        :stream t
                        :key (isp/read-file-contents "~/.config/secrets/anthropic-console")))

(use-package elysium)
