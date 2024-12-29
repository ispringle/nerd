;;https://emacs.dyerdwelling.family/emacs/20231221210441-emacs--selected-window-accent/
(defun isp/active-window-accent ()
  "Set's the fringe color of the active window."
  (interactive)
  (set-face-background 'fringe (ef-themes-get-color-value 'bg-mode-line))
  (walk-windows
   (lambda (window)
     (if (eq window (selected-window))
         (progn
           (set-window-margins window 0 0)
           (set-window-fringes window 10 0 t nil))
       (progn
         (set-window-margins window 0 0)
         (set-window-fringes window 0 0 t nil))
       )
     )
   t t))

(add-hook 'window-state-change-hook 'isp/active-window-accent)
