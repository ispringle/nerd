(define-public yt-dlp
  (package
    (name "yt-dlp")
    (version "2025.03.25")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yt-dlp/yt-dlp/")
             (commit version)))
       (file-name (git-file-name name version))
       (modules '((guix build utils)))
       (snippet '(substitute* "pyproject.toml"
                   (("^.*Programming Language :: Python :: 3\\.13.*$") "")))
       (sha256
        (base32 "10xgvvrsvhajrjfq512hjfg7kfcab4cbnhnl5lm6ispgpbv03n52"))))
    (build-system pyproject-build-system)
    (arguments
     `(#:tests? ,(not (%current-target-system))
       #:test-flags '("--ignore=test/test_websockets.py")
       #:phases
       (modify-phases %standard-phases
         ;; See <https://issues.guix.gnu.org/43418#5>.
         ;; ffmpeg is big but required to request free formats from, e.g.,
         ;; YouTube so pull it in unconditionally.  Continue respecting the
         ;; --ffmpeg-location argument.
         (add-after 'unpack 'default-to-the-ffmpeg-input
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "yt_dlp/postprocessor/ffmpeg.py"
               (("location = self.get_param(.*)$")
                (string-append
                  "location = '"
                  (dirname (search-input-file inputs "bin/ffmpeg"))
                  "'\n")))))
         (add-before 'build 'build-generated-files
           (lambda* (#:key inputs #:allow-other-keys)
             (if (assoc-ref inputs "pandoc")
               (invoke "make"
                       "PYTHON=python"
                       "yt-dlp"
                       "yt-dlp.1"
                       "completions")
               (invoke "make"
                       "PYTHON=python"
                       "yt-dlp"
                       "completions"))))
         (replace 'check
           (lambda* (#:key tests? test-flags #:allow-other-keys)
             (when tests?
               (apply invoke "pytest" "-k" "not download" test-flags)))))))
    (inputs (list ffmpeg python-brotli
                  python-certifi
                  python-mutagen
                  python-pycryptodomex
                  python-requests-next ; TODO Remove this special package
                  python-urllib3-next  ; TODO Remove this one too
                  python-websockets))
    (native-inputs
     (append
       ;; To generate the manpage.
       (if (supported-package? pandoc)
         (list pandoc)
         '())
       (list nss-certs-for-test python-hatchling python-pytest zip)))
    (synopsis "Download videos from YouTube.com and other sites")
    (description
     "yt-dlp is a small command-line program to download videos from
YouTube.com and many more sites.  It is a fork of youtube-dl with a
focus on adding new features while keeping up-to-date with the
original project.")
    (properties '((release-monitoring-url . "https://pypi.org/project/yt-dlp/")))
    (home-page "https://github.com/yt-dlp/yt-dlp")
    (license license:public-domain)))
