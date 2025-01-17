(define-module (config home foreign-packages)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages chromium)
  #:use-module (config packages vend)
  #:export (nerd-pkgs))
(use-package-modules compression curl fonts freedesktop gimp glib gnome gnome-xyz
                     gstreamer kde-frameworks linux music package-management
                     password-utils pdf pulseaudio shellutils ssh syncthing terminals
                     video web-browsers wget wm xdisorg xorg emacs emacs-xyz librewolf
                     chromium image qt mail rust-apps gnupg w3m web)
(define nerd-pkgs
    (list
     ;; Wayland/WM related utils
     grim
     slurp
     wl-clipboard
     mako
     fyi
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
     mu
     offlineimap3
     
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

     ;; Common Lisp
     vend
     
     ;; Shell tools
     w3m
     jq
     yq
     htmlq))
