;; this needs to be worked on
(define-module (config home services sway)
  #:use-module (gnu)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:export (nerd-sway-service-type))

(use-package-modules compression curl fonts freedesktop gimp glib gnome gnome-xyz
                     gstreamer kde-frameworks linux music package-management
                     password-utils pdf pulseaudio shellutils ssh syncthing terminals
                     video web-browsers wget wm xdisorg xorg)

(define (nerd-sway-pkgs-service config)
  (list swayfx
        swayidle
        swaylock
        wl-clipboard
        mako
        foot
        gammastep
        grimshot ;; grimshot --notify copy area
	rofi-wayland
	waybar
        network-manager-applet))

(define (nerd-sway-env-variables config)
  '())

(define nerd-sway-service-type
  (service-type (name 'home-sway)
                (description "My SwayWM environment service.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        nerd-sway-pkgs-service)
                       (service-extension
                        home-environment-variables-service-type
                        nerd-sway-env-variables)
		       (service-extension
			home-sway-service-type
			nerd-sway-configuration))
                (default-value #f)))
