;; https://github.com/subframe7536/maple-font/releases/download/v7.0-beta32/MapleMono-NF-CN.zip

(define-module (config packages maple)
  #:use-module (guix)
  #:use-module (guix packages)
  #:use-module (guix build-system font)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:export (font-maple))

(define font-maple
  (package
   (name "font-maple")
   (version "7.0-beta32")
   (source
    (origin
     (method url-fetch)
     (uri
      (string-append "https://github.com/subframe7536/maple-font/releases/download/v"
                     version
                     "/MapleMono-NF-CN.zip"))
     (sha256
      (base32 "0spm16znmxi0qxksdzqz26dqijz8iy4wbg8m5w0y2alkar3hpdcd"))))
   (build-system font-build-system)
   (home-page "https://monocraft.idreesinc.com/")
   (synopsis "Mono: Open source monospace font with round corner, ligatures and Nerd-Font for IDE and command line.")
   (description
    "Maple Mono is an open source monospace font focused on smoothing your coding flow.
I create it to enhance my working experience, and hope that it can be useful to others.
V7 is a completely remade version, providing variable font, redesigning more than half of the glyphs and offering smarter ligatures. ")
   (license license:silofl1.1)))
s
