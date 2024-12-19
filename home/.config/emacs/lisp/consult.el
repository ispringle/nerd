(use-package consult
  :demand
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)  
  (setq consult-preview-key "C-l")
  (setq consult-narrow-key "<"
        consult-widen-key ">")
  :bind
  (("C-c M-x" . consult-mode-command))
  :config
  (global-set-key [remap imenu] 'consult-imenu)
  (global-set-key [remap switch-to-buffer] 'consult-buffer)
  (global-set-key [remap goto-line] 'consult-goto-line)
  (consult-customize consult-theme
                     :preview-key
                     '("M-."
                       :debounce 0.5 "<up>" "<down>"
                       :debounce 1 any)))

(use-package consult-dir
  :ensure t
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))
