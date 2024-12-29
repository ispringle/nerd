;; Just random functions that don't have a better place to live right now.

(defun isp/strip-html ()
  "Remove HTML tags from the current buffer, 
   (this will affect the whole buffer regardless of the restrictions in effect)."
  (interactive "*")
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "<[^<]*>" (point-max) t)
        (replace-match "\\1"))
      (goto-char (point-min))
      (replace-string "&copy;" "(c)")
      (goto-char (point-min))
      (replace-string "&amp;" "&")
      (goto-char (point-min))
      (replace-string "&lt;" "<")
      (goto-char (point-min))
      (replace-string "&gt;" ">")
      (goto-char (point-min)))))

(defun isp/read-file-contents (file-path)
  "Read the contents of FILE-PATH and return it as a string."
  (with-temp-buffer
    (insert-file-contents file-path)
    (buffer-string)))

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
