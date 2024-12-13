(define-module (config systems base)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system nss)
  #:use-module (gnu system privilege)
  #:use-module (nongnu packages linux)
					;  #:use-module (nongnu packages linux-initrd)
  #:export (system-config))

(use-service-modules guix admin sysctl pm nix avahi dbus cups desktop linux
                     mcron networking xorg ssh docker audio virtualization)

(use-package-modules audio video nfs certs shells ssh linux bash emacs gnome
                     networking wm fonts libusb cups freedesktop file-systems
                     version-control package-management vim)

(define* (system-config #:key home system)
  (operating-system
   (inherit system)
   (kernel linux)
   (firmware (list linux-firmware))
					;   (initrd microcode-initrd)
   (locale "en_US.utf8")
   (timezone "America/Chicago")
   (keyboard-layout (keyboard-layout "us"))

   (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(targets (list "/boot/efi"))
		(keyboard-layout keyboard-layout)))

   (users (cons* (user-account
                  (name "ian")
                  (comment "Ian")
                  (group "users")
                  (home-directory "/home/ian")
                  (supplementary-groups '("wheel"
					  "netdev"
					  "audio"
					  "video"
					  "tty"
					  "input"
					  "docker"
					  "realtime"
					  "lp")))
		 %base-user-accounts))

   (groups (cons (user-group (system? #t) (name "realtime"))
		 %base-groups))

   (packages (cons* bluez
		    bluez-alsa
		    brightnessctl
		    emacs-pgtk
		    exfat-utils
		    git
		    gvfs
		    stow
		    %base-packages))
   
   (services (append
	      (modify-services %base-services
			       (delete login-service-type)
			       (delete mingetty-service-type)
			       (delete console-font-service-type))
	      (operating-system-user-services system)
	      (list
	       (service guix-home-service-type
			`(("ian" ,home)))
	       (service elogind-service-type)
	       (service greetd-service-type
			(greetd-configuration
			 (greeter-supplementary-groups (list "video" "input" "lp"))
			 (terminals
			  (list
			   (greetd-terminal-configuration (terminal-vt "1")
							  (terminal-switch #t))
			   (greetd-terminal-configuration (terminal-vt "2"))
			   (greetd-terminal-configuration (terminal-vt "3"))))))
	       (service screen-locker-service-type
			(screen-locker-configuration
			 (name "swaylock")
			 (program (file-append swaylock "/bin/swaylock"))
			 (using-pam? #t)
			 (using-setuid? #f)))
	       (simple-service 'add-nonguix-substitutes
                               guix-service-type
                               (guix-extension
                                (substitute-urls
                                 (append (list "https://substitutes.nonguix.org")
                                         %default-substitute-urls))
                                (authorized-keys
                                 (append (list (plain-file "nonguix.pub"
                                                           "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                                         %default-authorized-guix-keys))))
	       polkit-wheel-service
	       (simple-service 'mount-setuid-helpers
                               privileged-program-service-type
                               (map (lambda (program)
                                      (privileged-program
                                       (program program)))
                                    (list (file-append nfs-utils "/sbin/mount.nfs")
                                          (file-append ntfs-3g "/sbin/mount.ntfs-3g"))))
               (service network-manager-service-type
                        (network-manager-configuration
                         (vpn-plugins
                          (list network-manager-openvpn))))
               (service wpa-supplicant-service-type)
               (service bluetooth-service-type
                        (bluetooth-configuration
                         (auto-enable? #t)))
               (service usb-modeswitch-service-type)
               (service avahi-service-type)
               (service udisks-service-type)
               (service upower-service-type)
               (service cups-pk-helper-service-type)
               (service geoclue-service-type)
               (service polkit-service-type)
               (service dbus-root-service-type)
               fontconfig-file-system-service
               (service thermald-service-type)
               (service containerd-service-type)
               (service docker-service-type)
               (service libvirt-service-type
                        (libvirt-configuration
                         (unix-sock-group "libvirt")
                         (tls-port "16555")))
               (service openssh-service-type
                        (openssh-configuration
                         (openssh openssh-sans-x)
                         (port-number 2222)))
               (service sane-service-type)
               (service cups-service-type
                        (cups-configuration
                         (web-interface? #t)
                         (extensions
                          (list cups-filters))))
               (service x11-socket-directory-service-type)
               (service ntp-service-type)
               (udev-rules-service 'pipewire-add-udev-rules pipewire)
               (udev-rules-service 'brightnessctl-udev-rules brightnessctl)
               (simple-service 'system-cron-jobs
                               mcron-service-type
                               (list
                                ;; Run `guix gc' 5 minutes after midnight every day.
                                ;; Clean up generations older than 2 months and free
                                ;; at least 10G of space.
                                #~(job "5 0 * * *" "guix gc -d 2m -F 10G"))))))))
   
