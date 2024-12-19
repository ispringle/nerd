(use-package helpful
  :custom (elisp-refs-verbose nil)
  :bind
  (("M-g M-d" . 'helpful-at-point)
  ([remap describe-key] . helpful-key)
  ([remap describe-function] . helpful-callable)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)))
