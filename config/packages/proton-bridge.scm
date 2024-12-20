(define-module (config packages proton-bridge)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages pkg-config))

(define-public proton-bridge
  (package
   (name "proton-bridge")
   (version "3.16.0")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/ProtonMail/proton-bridge")
                  (commit (string-append "v" version))))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "0jiwmymrrg338jmbgfpmqkfh29rg7ys6w6bb86l614h84jh2sc5v"))))
   (build-system go-build-system)
   (arguments
    `(#:import-path "github.com/ProtonMail/proton-bridge"
      #:phases
      (modify-phases %standard-phases
        (replace 'build
          (lambda* (#:key import-path #:allow-other-keys)
                   (with-directory-excursion (string-append "src/" import-path)
                                             (setenv "GOTOOLCHAIN" "local")
              ;; Force module mode
              (setenv "GO111MODULE" "on")
                                             (invoke "make" "build-nogui")))))))
   (native-inputs
    `(("pkg-config" ,pkg-config)
      ("tar" ,tar)
      ("unzip" ,unzip)
      ("zip" ,zip)
      ("curl" ,curl)))
   (inputs
    `(("libsecret" ,libsecret)
      ("libglvnd" ,libglvnd)))
   (synopsis "ProtonMail Bridge for using native email clients")
   (description "The ProtonMail Bridge is an application that runs on your
computer in the background and enables the integration of your ProtonMail
account with popular email clients that support IMAP and SMTP protocols.")
   (home-page "https://github.com/ProtonMail/proton-bridge")
   (license license:gpl3+)))
proton-bridge
