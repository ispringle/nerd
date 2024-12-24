(define-module (config packages monocraft)
  #:use-module (guix)
  #:use-module (guix packages)
  #:use-module (guix build-system font)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:export (font-monocraft))

(define font-monocraft
  (package
   (name "font-monocraft")
   (version "4.0")
   (source
    (origin
     (method url-fetch)
     (uri
      (string-append "https://github.com/IdreesInc/Monocraft/releases/download/v"
                     version
                     "/Monocraft-nerd-fonts-patched.ttc"))
     (sha256
      (base32 "0dzhxbkzpkvz67290zmqpzs8vr3ywy1az1rpmxr8bgr633r1p04m"))))
   (build-system font-build-system)
   (home-page "https://monocraft.idreesinc.com/")
   (synopsis "A monospaced programming font inspired by the Minecraft typeface ")
   (description
    "")
   (license license:silofl1.1)))
