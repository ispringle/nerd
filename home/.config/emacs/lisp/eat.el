(use-package eat
  :ensure (:type git
		 :host codeberg
		 :repo "akib/emacs-eat"
		 :files ("*.el" ("term" "term/*.el") "*.texi"
			 "*.ti" ("terminfo/e" "terminfo/e/*")
			 ("terminfo/65" "terminfo/65/*")
			 ("integration" "integration/*")
			 (:exclude ".dir-locals.el" "*-tests.el")))
  :commands (eat eat-eshell-mode eat-eshell-visual-command-mode)
  :hook
  ('eshell-load-hook #'eat-eshell-mode)
  ('eshell-load-hook #'eat-eshell-visual-command-mode)
  :config
  (eat-compile-terminfo)
  (eat-eshell-mode))

