(define-module (config systems packages)
  #:use-module (config packages monaspace)
  #:use-module (config packages monocraft)
  #:use-module (config packages maple)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (nongnu packages fonts)
  #:use-module (nongnu packages linux)
  #:export (nerd-system-packages))

(use-package-modules admin audio video nfs certs shells ssh linux bash emacs gnome
                     networking wm fonts libusb cups freedesktop file-systems
                     version-control package-management compression base curl shellutils
		     wget text-editors rust-apps lsof pciutils gnome fontutils
                     commencement lisp python golang guile node rust tls
                     ninja ncurses android libusb)

(define nerd-system-packages
  (list
   ;; System utilities
   stow
   git
   bluez
   blueman
   htop                                 ; system monitoring
   curl                                 ; URL retrieval
   wget                                 ; another URL retrieval tool
   mg                                   ; lightweight emacs-style editor
   tree                                 ; directory listing
   ripgrep                              ; fast grep alternative
   fd                                   ; fast find alternative
   libmtp
   gvfs
   dropbear

   ;; Audio/Video
   sof-firmware
   
   ;; Fonts
   fontconfig
   font-google-roboto
   font-google-noto-emoji
   font-recursive
   font-microsoft-cascadia
   font-victor-mono
   font-jetbrains-mono   
   font-intel-one-mono
   font-liberation
   font-dejavu
   font-microsoft-web-core-fonts
   font-awesome
   font-fira-code
   font-google-noto
   font-monaspace
   font-monocraft
   font-scientifica
   font-maple

   ;; Mandatory Program Languages
   gcc-toolchain
   sbcl
   python
   go
   node
   rust

   ;; Build utils
   gnu-make
   ninja
   ncurses
   
   ;; Compression tools
   zip
   unzip
   p7zip
   
   ;; Network tools
   openssh                              ; SSH client/server
   openssl
   socat
   ;; nss-certs              ; SSL certificates
   ;; bind                   ; DNS utilities (dig, nslookup)
   
   ;; System monitoring and debugging
   lsof                                 ; list open files
   pciutils                             ; lspci
   usbutils                             ; lsusb

   ;; Dev/Debug tools
   adb
   
   ;; Shells
   fish                                 ; friendly shell
   ))

