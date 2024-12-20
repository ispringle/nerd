(define-module (config systems voltaire)
  #:use-module (gnu)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu system nss)
  #:use-module (gnu system privilege)
  #:use-module (guix channels)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:export (voltaire-system))

(use-service-modules guix admin sysctl pm nix avahi dbus cups desktop linux
                     mcron networking xorg ssh docker audio virtualization)

(use-package-modules admin audio video nfs certs shells ssh linux bash emacs gnome
                     networking wm fonts libusb cups freedesktop file-systems
                     version-control package-management compression base curl shellutils
		     wget text-editors rust-apps lsof pciutils)

(define %my-base-packages
  (append
   (list
    ;; System utilities
    stow
    git
    bluez
    htop                                ; system monitoring
    curl                                ; URL retrieval
    wget                                ; another URL retrieval tool
    mg                                  ; lightweight emacs-style editor
    tree                                ; directory listing
    ripgrep                             ; fast grep alternative
    fd                                  ; fast find alternative
    
    ;; Compression tools
    zip
    unzip
    p7zip
    
    ;; Network tools
    openssh            ; SSH client/server
    ;; nss-certs              ; SSL certificates
    ;; bind                   ; DNS utilities (dig, nslookup)
    
    ;; System monitoring and debugging
    lsof                                ; list open files
    pciutils                            ; lspci
    usbutils                            ; lsusb
    
    ;; Shell utilities
    fish                                ; friendly shell
    )
   %base-packages))

(define voltaire-system
  (operating-system
   (host-name "voltaire")
   (locale "en_US.utf8")
   (timezone "America/Chicago")
   (keyboard-layout (keyboard-layout "us"))
   
   ;; Use non-free Linux kernel and microcode
   (kernel linux)
   (initrd microcode-initrd)
   (firmware (list linux-firmware
                   sof-firmware))

   ;; Bootloader
   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))))

   ;; File systems
   (file-systems (cons* (file-system
			 (mount-point "/boot/efi")
			 (device (uuid "43F0-4920"
                                       'fat32))
			 (type "vfat"))
			(file-system
			 (mount-point "/")
			 (device (uuid
                                  "831b61f9-bdc8-4893-9c0b-dc0b20523bfe"
                                  'ext4))
			 (type "ext4"))
			%base-file-systems))
   (swap-devices (list (swap-space
			(target (uuid
				 "5e50bab7-ab09-47ef-b95c-192ef5e7ff4a")))))

   ;; Users
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
					  "libvirt"
					  "lp")))
		 %base-user-accounts))

   (packages %my-base-packages)


   ;; System Services
   (services
    (append
     (modify-services %base-services
		      (delete login-service-type)
		      (delete mingetty-service-type)
		      (delete console-font-service-type))
     (list
      ;; Login/Session management
      (service elogind-service-type)
      (service greetd-service-type
               (greetd-configuration
		(greeter-supplementary-groups (list "video" "input" "lp"))
		(terminals
		 (list (greetd-terminal-configuration (terminal-vt "1")
						      (terminal-switch #t))))))
      
      ;; Networking
      (service network-manager-service-type
               (network-manager-configuration
                (vpn-plugins (list network-manager-openvpn))))
      (service wpa-supplicant-service-type)
      (service avahi-service-type)
      (service openssh-service-type
               (openssh-configuration
                (port-number 2222)))
      
      ;; System services
      (service bluetooth-service-type
               (bluetooth-configuration
                (auto-enable? #t)))
      (service containerd-service-type)
      (service docker-service-type)
      (service libvirt-service-type
               (libvirt-configuration
                (unix-sock-group "libvirt")))
      
      ;; Printing
      (service cups-service-type
               (cups-configuration
                (web-interface? #t)
                (extensions
                 (list cups-filters))))
      
      ;; System maintenance
      (simple-service 'system-cron-jobs
                      mcron-service-type
                      (list
                       #~(job "5 0 * * *" ; Run at 00:05 every day
                              "guix gc -d 2m -F 10G")))
      
      ;; NonGuix substitutes
      (simple-service 'add-nonguix-substitutes
                      guix-service-type
                      (guix-extension
                       (substitute-urls
                        (append (list "https://substitutes.nonguix.org")
                                %default-substitute-urls))
                       (authorized-keys
                        (append (list (plain-file "nonguix.pub"
                                                  "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                                %default-authorized-guix-keys)))))))))

voltaire-system
