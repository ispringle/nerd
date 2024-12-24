(use-package yasnippet
  :config
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets/"
                                                   user-emacs-directory))
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package license-snippets
  :after yasnippet
  :config
  (license-snippets-init))
