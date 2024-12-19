(use-builtin dired
	     :bind
	     (:map dired-mode-map
		   ("/" . dired-goto-file)
		   ("," . dired-create-directory)
		   ("." . dired-create-empty-file)
		   ("I" . dired-insert-subdir)
		   ("K" . dired-kill-subdir)
		   ("O" . dired-find-file-other-window)
		   ("[" . dired-prev-dirline)
		   ("]" . dired-next-dirline)
		   ("o" . dired-up-directory)
		   ("^" . mode-line-other-buffer)
		   ("x" . dired-do-delete)
		   ("X" . dired-do-flagged-delete)
		   ("y" . dired-do-copy))
	     :custom
	     (dired-listing-switches "-l --almost-all --human-readable --time-style=long-iso --group-directories-first --no-group")
	     :config
	     (when (eq system-type 'darwin)
	       (setq insert-directory-program "gls")))
(use-builtin dired-x
	     :config
	     (setq dired-omit-files (concat dired-omit-files "\\|^\\..*$")))
(use-builtin dired-aux)
(use-builtin image-dired
	     :custom
	     (image-dired-thumb-size 256)
	     (image-dired-marking-shows-next nil)
	     :bind
	     (:map image-dired-thumbnail-mode-map
		   ("n" . image-dired-next-line)
		   ("p" . image-dired-previous-line)
		   ("i" . image-dired-forward-image)
		   ("o" . image-dired-backward-image)))
(use-builtin wdired)
(use-package diredfl
  :hook
  ('dired-mode-hook #'diredfl-mode)
  :config
  (set-face-attribute 'diredfl-dir-name nil :bold t))
