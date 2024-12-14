(define-module (config)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu home)
  #:use-module (guix gexp)
  #:use-module (config systems voltaire)
  #:use-module (config home base))

(define config
  (list (operating-system
	 (inherit voltaire-system))
	(home-environment
	 (inherit home-config))))

config
