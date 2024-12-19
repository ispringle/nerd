(define-module (config home foreign-packages)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages chromium)
  #:use-module (config packages proton-bridge)
  #:export (nerd-pkgs))
(use-package-modules compression curl fonts freedesktop gimp glib gnome gnome-xyz
                     gstreamer kde-frameworks linux music package-management
                     password-utils pdf pulseaudio shellutils ssh syncthing terminals
                     video web-browsers wget wm xdisorg xorg emacs emacs-xyz librewolf
                     chromium image qt mail rust-apps password-utils gnupg w3m)
(define nerd-pkgs
    (list
     ;; WM related stuff
     flameshot
     wl-clipboard
     mako
     foot
     gammastep
     waybar
     fuzzel
     xorg-server-xwayland
     qtwayland
     
     ;; XDG and Desktop Integration
     xdg-desktop-portal
     xdg-desktop-portal-gtk
     xdg-desktop-portal-wlr
     xdg-utils
     xdg-dbus-proxy
     shared-mime-info
     network-manager-applet

     ;; Emacs
     emacs-next-pgtk

     ;; email
     proton-bridge
     hydroxide                    ; third party, cli-only protonbridge basically
     mu
     isync
     
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
     nyxt
     librewolf
     ;; ungoogled-chromium-wayland
     
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

     ;; Security
     rbw
     password-store
     pinentry
     
     ;; Shell tools
     w3m))
