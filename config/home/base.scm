(define-module (config home base)
  #:use-module (config home services desktop)
  #:use-module (config home services udiskie)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services dotfiles)
  #:use-module (gnu home services desktop)
  #:export (home-base-services))

(define home-base-services
  (list
   ;; Evaluate just using `stow' for config files.
   ;;   (service home-dotfiles-service-type
   ;;	    (home-dotfiles-configuration
   ;;	     (directories '("../../files/home"))))
   (simple-service 'profile-env-vars-service
		   home-environment-variables-service-type
		   '(("LC_COLLATE" . "C")
		     ("VISUAL" . "emacsclient")
		     ("EDITOR" . "emacsclient")
		     ("PATH" . "$HOME/.bin:$HOME/.local/bin:$PATH")
		     ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share")
		     ("XDG_CURRENT_DESKTOP" . "sway")
		     ("XDG_SESSION_TYPE" . "wayland")
		     ("RTC_USE_PIPEWIRE" . "true")
		     ("SDL_VIDEODRIVER" . "wayland")
		     ("MOZ_ENABLE_WAYLAND" . "1")
		     ("CLUTTER_BACKEND" . "wayland")
		     ("ELM_ENGINE" . "wayland_egl")
		     ("ECORE_EVAS_ENGINE" . "wayland_egl")
		     ("QT_QPA_PLATFORM" . "wayland_egl")))
   (service home-dbus-service-type)
   (service home-desktop-service-type)
   (service home-udiskie-service-type)))
