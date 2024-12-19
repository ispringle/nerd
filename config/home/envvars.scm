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
    ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/usr/local/share:/usr/share")
    ("PATH" . "$HOME/.bin:$HOME/.local/bin:$PATH")
    ("XDG_CURRENT_DESKTIOP" . "sway")
    ("XDG_SESSION_TYPE" . "wayland")
    ("XDG_SESSION_DESKTOP" . "sway")
    ("_JAVA_AWT_WM_NONREPARENTING" . "1")
    ("MOZ_ENABLE_WAYLAND" . "1")
    ("QT_QPA_PLATFORM" . "wayland")
    ("SDL_VIDEODRIVER" . "wayland")
    ("QT_PLUGIN_PATH" . "$(guix build qtwayland@6)/lib/qt6/plugins")
    ("QT_QPA_PLATFORM_PLUGIN_PATH" . "$QT_PLUGIN_PATH/platforms")))
