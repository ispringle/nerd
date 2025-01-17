(define-module (config home base)
  #:use-module (config home sway)
  #:use-module (config home envvars)
  #:use-module (config home foreign-packages)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services sway)
  #:use-module (gnu home services fontutils)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:export (home-config))

(define home-config
  (home-environment
   (packages nerd-pkgs)
   
   (services
    (list
     (simple-service 'additional-fonts-service
                     home-fontconfig-service-type
                     (list '(alias
                             (family "monospace")
                             (prefer
                              (family "Maple Mono NF CN")
                              (family "FontAwesome")))))
     (service home-sway-service-type
              nerd-sway-config)
     (simple-service 'source-guix-profile home-shell-profile-service-type
                     (list (plain-file "guix-env-src"
                                       (string-append
                                        "GUIX_PROFILE=\"$HOME/.guix-profile\"\n"
                                        ". $GUIX_PROFILE/etc/profile"))))
     (service home-bash-service-type
              (home-bash-configuration
               (guix-defaults? #t)
               ;; (bash-profile '(". $GUIX_PROFILE/etc/profile"))
               (aliases
                '(("ll" . "ls -l")
                  ("la" . "ls -la")
                  ("g" . "git")
                  ("gc" . "git commit")
                  ("gp" . "git push")))))
     (simple-service 'extra-env-vars-service
		     home-environment-variables-service-type
		     nerd-env-vars)))))

home-config
