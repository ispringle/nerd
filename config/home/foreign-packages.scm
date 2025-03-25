(define-module (config home foreign-packages)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages chromium)
  #:use-module (config packages vend)
  #:use-module (nongnu packages messaging)
  #:export (nerd-pkgs))

(use-package-modules compression curl fonts freedesktop gimp glib gnome gnome-xyz
                     gstreamer kde-frameworks linux music package-management ebook
                     password-utils pdf pulseaudio shellutils ssh syncthing terminals
                     video web-browsers wget wm xdisorg xorg emacs emacs-xyz librewolf
                     chromium image qt mail rust-apps gnupg w3m web admin xdisorg)
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
     fuzzel
     xorg-server-xwayland
     wtype
     
     ;; QT
     qtwayland
     qt5ct
     qtsvg
     qt6ct
     
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

     ;; messaging
     mu
     offlineimap3
     signal-desktop
     
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
     ungoogled-chromium/wayland
     
     ;; Audio/Video
     mpv
     mpv-mpris
     yt-dlp
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
     gnome-keyring
     libsecret

     ;; Common Lisp
     vend

     ;; Misc
     calibre
     
     ;; Shell tools
     w3m
     jq
     yq
     htmlq
     tree
     fastfetch
     fyi))
