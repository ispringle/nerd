(define-module (config packages monaspace)
  #:use-module (guix)
  #:use-module (guix packages)
  #:use-module (guix build-system font)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:export (font-monaspace))

(define font-monaspace
  (package
   (name "font-monaspace")
   (version "1.101")
   (source
    (origin
     (method url-fetch)
     (uri
      "https://github.com/githubnext/monaspace/archive/refs/tags/v1.101.tar.gz")
     (sha256
      (base32 "076gx85and4xb262y0rbqvy7f6w732krzlh236xr7v3zbsw1h872"))))
   (build-system font-build-system)
   (home-page "https://monaspace.githubnext.com")
   (synopsis "An innovative superfamily of fonts for code")
   (description
    "The Monaspace type system is a monospaced type superfamily with some modern tricks up its sleeve.
     It consists of five variable axis typefaces. Each one has a distinct voice, but they are all metrics-compatible with one another,
     allowing you to mix and match them for a more expressive typographical palette.")
   (license license:silofl1.1)))
