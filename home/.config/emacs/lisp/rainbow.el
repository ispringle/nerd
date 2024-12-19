(use-package rainbow-delimiters
  :demand t
  :ensure t
  :hook
  ((prog-mode . rainbow-delimiters-mode)
   (minibuffer-setup . rainbow-delimiters-mode)))
