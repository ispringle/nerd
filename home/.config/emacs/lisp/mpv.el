(use-package mpv
  :config
  (advice-add 'mpv-start :override
              (lambda (&rest args)
                (mpv-kill)
                (let ((socket (expand-file-name "mpvsocket" temporary-file-directory)))
                  (setq mpv--process
                        (apply #'start-process "mpv-player" nil mpv-executable
                               "--no-terminal"
                               (concat "--input-ipc-server=" socket)
                               (append mpv-default-options args)))
                  (set-process-query-on-exit-flag mpv--process nil)
                  (set-process-sentinel
                   mpv--process
                   (lambda (process _event)
                     (when (memq (process-status process) '(exit signal))
                       (mpv-kill)
                       (when (file-exists-p socket)
                         (condition-case ()
                             (delete-file socket)
                           (file-error
                            (message "Failed to clean up mpv socket %s" socket))))
                       (run-hooks 'mpv-on-exit-hook))))
                  (with-timeout
                      (mpv-start-timeout (mpv-kill)
                                         (error "Failed to connect to mpv"))
                    (while (not (file-exists-p socket))
                      (sleep-for 0.05)))
                  (setq mpv--queue (tq-create
                                    (make-network-process :name "mpv-socket"
                                                          :family 'local
                                                          :service socket)))
                  (set-process-filter
                   (tq-process mpv--queue)
                   (lambda (_proc string)
                     (mpv--tq-filter mpv--queue string)))
                  (run-hook-with-args 'mpv-on-start-hook args)
                  t))))
