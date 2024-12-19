(use-package crux
  :bind (("C-k" . crux-smart-kill-line)
         ("C-RET" . crux-smart-open-line-above)
         ("S-RET" . crux-smart-open-line)
         ("C-c TAB" . crux-cleanup-buffer-or-region)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-c d" . crux-duplicate-current-line-or-region)
         ("C-c M-d" . crux-duplicate-and-comment-current-line-or-region)))
