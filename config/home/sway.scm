(define-module (config home sway)
  #:use-module (gnu home services sway)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages rust-apps)
  #:export (nerd-sway-config))

(define wallpaper
  "/home/ian/Wallpapers/current")

(define nerd-variables `((mod . "Mod4")
		         (left  . "b")
		         (down  . "n")
		         (up    . "p")
		         (right . "f")
		         (editor . "emacsclient -c")
		         (term . "footclient")
		         (menu . "fuzzel")))

(define nerd-keybindings
  `( ;; Sway Shortcuts
    ($mod+Shift+q . "kill")
    ($mod+Shift+r . "reload")
    ($mod+d . "exec $menu")
    ($mod+Shift+Escape . "exec system-menu")

    ;; Program shortcuts
    ($mod+Return . "exec $term")
    ($mod+i . "exec nyxt")
    ($mod+Shift+i . "exec librewolf")
    ($mod+e . "exec emacsclient -nc")
    ($mod+Shift+e . "exec emacsclient --eval \"(emacs-everywhere)\"")
    ($mod+s . "exec ghettoshot")

    ;; Window manipulation
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

    ;; Workspace
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
    ($mod+Shift+0 . "move container to workspace number 10")

    ;; Volume
    ($mod+equal . "exec pactl set-sink-volume @DEFAULT_SINK@ +5%") ; Up
    (XF86AudioRaiseVolume . "exec pactl set-sink-volume @DEFAULT_SINK@ +5%") ; Up
    ($mod+minus . "exec pactl set-sink-volume @DEFAULT_SINK@ -5%") ; Down
    (XF86AudioLowerVolume . "exec pactl set-sink-volume @DEFAULT_SINK@ -5%") ; Down
    ($mod+m . "exec pactl set-sink-mute @DEFAULT_SINK@ toggle")        ; Mute
    (XF86AudioMute . "exec pactl set-sink-mute @DEFAULT_SINK@ toggle") ; Mute

    ;; Bar replacement
    ($mod+Backspace . "exec ~/.bin/workspace_launcher")
    ($mod+Tab . "exec ~/.bin/window_launcher")
    ($mod+Shift+T . "exec ~/.bin/time_notify")))

(define nerd-gestures (list))

(define nerd-packages (list swayfx
                            swaybg
                            swaylock
                            swayidle
                            swayr       ; TODO: set this up
                            ))

(define nerd-inputs (list))

(define nerd-outputs (list (sway-output
                            (identifier '*)
                            (background wallpaper))))

(define nerd-bar (sway-bar))

(define nerd-modes
  (list
   (sway-mode
    (mode-name "resize")
    (keybindings
     '(($left . "resize shrink width 10px")
       ($down . "resize grow height 10px")
       ($up . "resize shrink height 10px")
       ($right . "resize grow width 10px")
       (Return . "mode \"default\"")
       (Escape . "mode \"default\""))))))

(define nerd-startup+reload-programs (list))

(define nerd-startup-progs
  (list "emacs --daemon"
        "foot -s"
        "mako"
        "dbus-update-activation-environment --all"
        "~/.bin/proton-bridge -n"
        "offlineimap"))

(define nerd-extra-content
  `("corner_radius 2"
    "smart_borders on"
    "default_border pixel 3"
    "gaps inner 5"
    "blur enable"

    ;; Theme
    "client.focused          #5fa824     #5fa824     #fafafa     #4d8f21     #5fa824"
    "client.focused_inactive #2f4440     #2f4440     #b3b3b3     #2f4440     #2f4440"
    "client.unfocused        #1a1f1f     #1a1f1f     #8f8f8f     #1a1f1f     #1a1f1f"
    "client.urgent           #c42d2f     #c42d2f     #fafafa     #c42d2f     #c42d2f"
    "client.placeholder      #1a1f1f     #1a1f1f     #8f8f8f     #1a1f1f     #1a1f1f"

    ;; Time notify
    "bindcode 133+134 exec ~/.bin/time_notify" ; Tap both super keys
    ))

(define nerd-sway-config
  (sway-configuration
   (variables nerd-variables)
   (keybindings nerd-keybindings)
   (gestures nerd-gestures)
   (packages nerd-packages)
   (inputs nerd-inputs)
   (outputs nerd-outputs)
   ;; (bar nerd-bar)
   (modes nerd-modes)
   (startup+reload-programs nerd-startup+reload-programs)
   (startup-programs nerd-startup-progs)
   (extra-content nerd-extra-content)))
