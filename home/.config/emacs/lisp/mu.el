(use-package mu
  :ensure `(mu4e :host github
                 :files ("mu4e/*.el"
                         "build/mu4e/mu4e-meta.el"
                         "build/mu4e/mu4e-config.el"
                         "build/mu4e/mu4e.info")
                 :repo "djcb/mu"
                 :main "mu4e/mu4e.el"
                 :build (:not elpaca--compile-info))
  :commands (mu4e mu4e-update-index)
  :custom
  (mail-user-agent 'mu4e-user-agent)
  (mu4e-kill-buffer-on-exit t)

  ;; Image viewing and HTML display
  (mu4e-view-show-images t)
  (mu4e-image-max-width 800)
  (mu4e-html2text-command "w3m -dump -T text/html")
  (w3m-command "w3m")
  
  (mu4e-change-filenames-when-move t)
  (mu4e-update-interval (* 10 60))
  (mu4e-compose-format-flowed t)

  (mu4e-get-mail-command "mbsync -Va")

  (mu4e-maildir "~/mail")
  (mu4e-drafts-folder "/Drafts")
  (mu4e-sent-folder "/Sent")
  (mu4e-refile-folder "/Archive")
  (mu4e-trash-folder "/Trash")
  
  (mu4e-maildir-shortcuts '(("/INBOX" . ?i)
                            ("/Sent" . ?s)
                            ("/Trash" . ?t)
                            ("/Drafts" . ?d)
                            ("/Archive" . ?a)))
  
  (message-send-mail-function 'smtpmail-send-it)
  (smtpmail-auth-credentials "~/.authinfo")
  (smtpmail-smtp-server "127.0.0.1")
  (smtpmail-smtp-service 1025)
  (smtpmail-stream-type 'starttls))

(use-package org-msg
  :after mu4e
  :custom
  (mail-user-agent 'mu4e-user-agent)
  (org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil authot:nil email:nil \\n:t")
  (org-msg-startup "hidestars indent inlineimages")
  (org-msg-default-alernatives '((new . (text html))
                                 (reply-to-html . (text html))
                                 (reply-to-text . (text))))
  (org-msg-convert-citation t)
  :config
  (org-msg-mode))
