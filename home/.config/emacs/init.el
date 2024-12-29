;; This goes first, it's need due to the heavy use of `use-package' and that it
;; installs all the modules
(load (expand-file-name "elpaca.el" user-emacs-directory))

;; Needed for the `:general' section of `use-package'
(load (expand-file-name "general.el" user-emacs-directory))

;; Must be set after `general' but before any other keybindings are set
(load (expand-file-name "which-key.el" user-emacs-directory))

;; Setting early to ensure theme variables exist if/when needed
(load (expand-file-name "themes.el" user-emacs-directory))
(elpaca-wait)

(message "Loading files.")

(mapc 'load
      (directory-files
       (expand-file-name "lisp" user-emacs-directory) 't "^[^#]*el$"))

(put 'narrow-to-region 'disabled nil)
