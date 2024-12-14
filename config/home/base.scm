(define-module (config home base)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services sway)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (nongnu packages mozilla)
  #:export (home-config))

(use-package-modules compression curl fonts freedesktop gimp glib gnome gnome-xyz
                     gstreamer kde-frameworks linux music package-management
                     password-utils pdf pulseaudio shellutils ssh syncthing terminals
                     video web-browsers wget wm xdisorg xorg emacs)


(define home-config
  (home-environment
   (packages
    (list 
     ;; Sway and Wayland Core
     sway
     emacs-pgtk
     swaylock
     swayidle
     wl-clipboard
     mako
     foot
     gammastep
     waybar
     fuzzel
     xorg-server-xwayland
     
     ;; XDG and Desktop Integration
     xdg-desktop-portal
     xdg-desktop-portal-gtk
     xdg-desktop-portal-wlr
     xdg-utils
     xdg-dbus-proxy
     shared-mime-info
     network-manager-applet

     ;; Device Management
     udiskie

     ;; Fonts
     font-iosevka-aile
     font-jetbrains-mono
     font-google-noto
     font-google-noto-emoji
     font-liberation
     font-awesome
     
     ;; Browsers
     firefox-esr
     nyxt
     
     ;; Audio/Video
     mpv
     mpv-mpris
     youtube-dl
     playerctl
     gstreamer
     gst-plugins-base
     gst-plugins-good
     gst-plugins-bad
     gst-plugins-ugly
     gst-libav
     alsa-utils
     pavucontrol

     ;; Shell tools
     ;;starship
     ))
   
   (services
    (list
     ;; Sway configuration
     (service home-sway-service-type
              (sway-configuration
	       (startup-programs
		(list "emacs --daemon"
		      "waybar"
		      "foot -s"
		      "mako"))
		      
	       (variables `((mod . "Mod4")
			    (left  . "b")
			    (down  . "n")
			    (up    . "p")
			    (right . "f")
			    (editor . "emacsclient -c")
			    (term . "footclient")
			    (menu . "fuzzel")))
	       (modes  (list
			(sway-mode
			 (mode-name "resize")
			 (keybindings
			  '(($left  . "resize shrink width 10px")
			    ($down  . "resize grow height 10px")
			    ($up    . "resize shrink height 10px")
			    ($right . "resize grow width 10px")                  
			    (Return . "mode \"default\"")
			    (Escape . "mode \"default\""))))))
	       (keybindings `(($mod+Return . "exec $term")
			      ($mod+Shift+q . "kill")
			      ($mod+i . "exec nyxt")
			      ($mod+Shift+i . "exec firefox")
			      ($mod+Shift+r . "reload")
			      ($mod+d . "exec $menu")
			      ($mod+$left . "focus left")
			      ($mod+$right . "focus right")
			      ($mod+$up . "focus up")
			      ($mod+$down . "focus down")
			      ($mod+Shift+$left . "move left")
			      ($mod+Shift+$right . "move right")
			      ($mod+Shift+$up . "move up")
			      ($mod+Shift+$down . "move down")
			      ($mod+v . "splitv")
			      ($mod+h . "splith")
			      ($mod+1 . "workspace number 1")
			      ($mod+2 . "workspace number 2")
			      ($mod+3 . "workspace number 3")
			      ($mod+4 . "workspace number 4")
			      ($mod+5 . "workspace number 5")
			      ($mod+6 . "workspace number 6")
			      ($mod+7 . "workspace number 7")
			      ($mod+8 . "workspace number 8")
			      ($mod+9 . "workspace number 9")
			      ($mod+0 . "workspace number 10")
			      ($mod+Shift+1 . "move container to workspace number 1")
			      ($mod+Shift+2 . "move container to workspace number 2")
			      ($mod+Shift+3 . "move container to workspace number 3")
			      ($mod+Shift+4 . "move container to workspace number 4")
			      ($mod+Shift+5 . "move container to workspace number 5")
			      ($mod+Shift+6 . "move container to workspace number 6")
			      ($mod+Shift+7 . "move container to workspace number 7")
			      ($mod+Shift+8 . "move container to workspace number 8")
			      ($mod+Shift+9 . "move container to workspace number 9")
			      ($mod+Shift+0 . "move container to workspace number 10")))))

     ;; Shared shell aliases and functions
     (service home-bash-service-type
              (home-bash-configuration
               (aliases
                '(("ll" . "ls -l")
                  ("la" . "ls -la")
                  ("g" . "git")
                  ("gc" . "git commit")
                  ("gp" . "git push")))))
     
     ;; Environment variables
     (simple-service 'extra-env-vars-service
		     home-environment-variables-service-type
		     `(("EDITOR" . "emacsclient")
                       ("VISUAL" . "emacsclient")
                       ("ALTERNATE_EDITOR" . "mg")
                       ("XDG_CACHE_HOME" . "$HOME/.cache")
                       ("XDG_CONFIG_HOME" . "$HOME/.config")
                       ("XDG_DATA_HOME" . "$HOME/.local/share")
                       ("XDG_DATA_DIRS" . "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/usr/local/share:/usr/share")
                       ("PATH" . "$HOME/.bin:$HOME/.local/bin:$PATH")))))))

home-config
