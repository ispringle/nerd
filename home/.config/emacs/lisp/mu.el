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
  (mu4e-refile-folder "/All Mail")
  (mu4e-trash-folder "/Trash")
  (mu4e-maildir-shortcuts '(("/inbox" . ?i)
                            ("/Sent" . ?s)
                            ("/Trash" . ?t)
                            ("/Drafts" . ?d)
                            ("/All Mail" . ?a)))
  (message-send-mail-function 'smtpmail-send-it
                              auth-sources '("~/.authinfo")
                              smtpmail-smtp-server "127.0.0.1"
                              smtpmail-smtp-service 1025
                              smtpmail-stream-type 'ssl))
