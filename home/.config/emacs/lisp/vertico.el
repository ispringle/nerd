(use-package vertico
  :ensure (vertico :files (:defaults "extensions/*"))
  :custom
  (vertico-count 13)
  (vertico-resize t)
  (vertico-cycle t)
  (vertico-multiform-categories '((embark-keybinding grid)))
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("S-DEL" . vertico-directory-delete-word))
  :hook
  ('rfn-eshadow-update-overlay #'vertico-directory-tidy)
  :init
  (vertico-mode))

(use-builtin savehist
  :init
  (savehist-mode))
