(define-module (config home envvars)
  #:export (nerd-env-vars))

(define nerd-env-vars
  `(("EDITOR" . "emacsclient")
    ("VISUAL" . "emacsclient")
    ("ALTERNATE_EDITOR" . "mg")
    
    ;; Fix for Nyxt, otherwise it crashes
    ("WEBKIT_DISABLE_COMPOSITING_MODE" . "1")
    
    ;; ("XDG_CACHE_HOME" . "$HOME/.cache")
    ;; ("XDG_CONFIG_HOME" . "$HOME/.config")
    ;; ("XDG_DATA_HOME" . "$HOME/.local/share")

    ;; Guix
    ("GUIX_PROFILE" . "$HOME/.guix-profile")

    ;; Guile
    ("GUILE_LOAD_PATH" . "$GUIX_PROFILE/share/guile/site/3.0:$GUILE_LOAD_PATH")
    
    ;; Bin locs
    ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/usr/local/share:/usr/share")
    ("PATH" . "$HOME/.bin:$HOME/.local/bin:$PATH")

    ;; Wayland / Sway
    ("XDG_CURRENT_DESKTOP" . "sway")
    ("XDG_SESSION_TYPE" . "wayland")
    ("XDG_SESSION_DESKTOP" . "sway")
    ("_JAVA_AWT_WM_NONREPARENTING" . "1")
    ("MOZ_ENABLE_WAYLAND" . "1")
    ("QT_QPA_PLATFORM" . "wayland")
    ("SDL_VIDEODRIVER" . "wayland")
    ("QT_PLUGIN_PATH" . "$(guix build qtwayland@6)/lib/qt6/plugins")
    ("QT_QPA_PLATFORM_PLUGIN_PATH" . "$QT_PLUGIN_PATH/platforms")))
