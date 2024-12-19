(load (expand-file-name "elpaca.el" user-emacs-directory))
(load (expand-file-name "general.el" user-emacs-directory))
(load (expand-file-name "which-key.el" user-emacs-directory))
(elpaca-wait)

(message "Loading files.")

(mapc 'load
      (directory-files
       (expand-file-name "lisp" user-emacs-directory) 't "^[^#]*el$"))

(put 'narrow-to-region 'disabled nil)
