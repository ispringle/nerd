(define-module (config packages vend)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix licenses)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:export (vend))

(define vend
  (package
   (name "vend")
   (version "0.1.0")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://github.com/fosskers/vend/archive/refs/tags/v"
                         version ".tar.gz"))
     (sha256
      (base32
       "1d2191dygsjcql6hd7j6h4ldki97sql9ya4zjsss3y0vahqj28fv"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
                     (delete 'configure)
                     (replace 'build
                              (lambda _
                                (setenv "HOME" (getcwd))
                                (mkdir-p ".ecl")
                                (invoke "ecl"
                                        "--load" "build.lisp")))
                     (replace 'install
                              (lambda* (#:key outputs #:allow-other-keys)
                                       (let ((out (assoc-ref outputs "out")))
                                         (install-file "vend" (string-append out "/bin"))
                                         #t))))))
   (native-inputs
    (list ecl))
   (home-page "https://example.com/vend")
   (synopsis "ECL-based Lisp package")
   (description "Vend is an ECL-based Lisp package.")
   (license gpl3+)))
