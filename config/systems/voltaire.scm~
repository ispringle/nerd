(define-module (config systems voltaire)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu system)
  #:use-module (guix)
  #:use-module (config systems base)
  #:use-module (config home base))

(use-service-modules cups desktop networking ssh xorg)

(system-config
 #:home
 (home-environment
  (services (cons* home-base-services)))
 
 #:system
 (operating-system
  (host-name "voltaire")

  (services
   (list (service gnome-desktop-service-type)
	 (service gnome-keyring-service-type)))

  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))
 
  (swap-devices (list (swap-space
                       (target (uuid
				"5e50bab7-ab09-47ef-b95c-192ef5e7ff4a")))))

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
		       %base-file-systems))))
