(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless partial-completion basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))
