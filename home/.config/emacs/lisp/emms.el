(use-package emms
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  :custom
  (emms-browser-covers #'emms-browser-cache-thumbnail-async))
