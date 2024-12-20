(use-modules (shepherd support))

(define offlineimap
  (service
   '(offlineimap)
   #:documentation "Run `offlineimap' service"
   #:start (make-forkexec-constructor
            '("offlineimap")
            #:log-file (string-append (getenv "HOME")
                                      "/.local/log/offlineimap.log"))
   #:stop (make-kill-destructor)
   #:respawn? #t))
(register-services (list offlineimap))
(start-service offlineimap)
