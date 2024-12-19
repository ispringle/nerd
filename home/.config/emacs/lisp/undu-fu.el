(use-package undo-fu
  :config
  (global-set-key [remap undo] 'undo-fu-only-undo)
  (global-set-key [remap undo-redo] 'undo-fu-only-redo)
  (global-set-key (kbd "C-S-/") 'undo-fu-only-redo))
