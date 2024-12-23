(define-module (config systems packages)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:export (nerd-system-packages))

(use-package-modules admin audio video nfs certs shells ssh linux bash emacs gnome
                     networking wm fonts libusb cups freedesktop file-systems
                     version-control package-management compression base curl shellutils
		     wget text-editors rust-apps lsof pciutils gnome)

;; make
;; go
;; ninja
(define nerd-system-packages
  (list
   ;; System utilities
   stow
   git
   bluez
   htop                                 ; system monitoring
   curl                                 ; URL retrieval
   wget                                 ; another URL retrieval tool
   mg                                   ; lightweight emacs-style editor
   tree                                 ; directory listing
   ripgrep                              ; fast grep alternative
   fd                                   ; fast find alternative
   
   ;; Compression tools
   zip
   unzip
   p7zip
   
   ;; Network tools
   openssh             ; SSH client/server
   ;; nss-certs              ; SSL certificates
   ;; bind                   ; DNS utilities (dig, nslookup)
   
   ;; System monitoring and debugging
   lsof                                 ; list open files
   pciutils                             ; lspci
   usbutils                             ; lsusb
   
   ;; Shell utilities
   fish                                 ; friendly shell
   ))
