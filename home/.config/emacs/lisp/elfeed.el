(require 'ffap)
(defun isp/elfeed-slugify (str)
  "Convert string STR to a `slug' and return that string."
  (let* (;; All lower-case
         (str (downcase str))
         ;; Remove "<FOO>..</FOO>" HTML tags if present.
         (str (replace-regexp-in-string "<\\(?1:[a-z]+\\)[^>]*>.*</\\1>" "" str))
         ;; Remove URLs if present in the string.  The ")" in the
         ;; below regexp is the closing parenthesis of a Markdown
         ;; link: [Desc](Link).
         (str (replace-regexp-in-string (concat "\\](" ffap-url-regexp "[^)]+)") "]" str))
         ;; Replace "&" with " and ", "." with " dot ", "+" with
         ;; " plus ".
         (str (replace-regexp-in-string
               "\\'" ""
               (replace-regexp-in-string
                "&" " and "
                (replace-regexp-in-string
                 "\\." ""
                 (replace-regexp-in-string
                  "\\+" " plus " str)))))
         ;; Replace all characters except alphabets, numbers and
         ;; parentheses with spaces.
         (str (replace-regexp-in-string "[^[:alnum:]()]" " " str))
         ;; Remove leading and trailing whitespace.
         (str (replace-regexp-in-string "\\(^[[:space:]]*\\|[[:space:]]*$\\)" "" str))
         ;; Replace 2 or more spaces with a single space.
         (str (replace-regexp-in-string "[[:space:]]\\{2,\\}" " " str))
         ;; Replace parentheses with double-hyphens.
         (str (replace-regexp-in-string "\\s-*([[:space:]]*\\([^)]+?\\)[[:space:]]*)\\s-*" " -\\1- " str))
         ;; Remove any remaining parentheses character.
         (str (replace-regexp-in-string "[()]" "" str))
         ;; Replace spaces with hyphens.
         (str (replace-regexp-in-string " " "-" str))
         ;; Remove leading and trailing hyphens.
         (str (replace-regexp-in-string "\\(^[-]*\\|[-]*$\\)" "" str)))
    str))

(use-package elfeed
  :defer t
  :bind
  ("C-x w" . elfeed)
  :custom
  (elfeed-feeds
   '(("https://profcj.org/feed/podcast/" dangerous-history longform history chrono)
     ("https://tomwoodsshow.libsyn.com/rss" periodical politics)
     ("https://www.dhunplugged.com/feed/" periodical finance)
     ("https://feeds.megaphone.fm/GLT1412515089" periodical talk)
     ("http://feed.nashownotes.com/rss.xml" periodical politics)))
  :config
  (defun isp/elfeed-podcast-tagger (entry)
    (when (elfeed-entry-enclosures entry)
      (elfeed-tag entry 'podcast)))
  (defun isp/elfeed-show-enclosure-filename-remote (entry url-enclosure)
    "Returns the remote filename as local filename for an enclosure."
    (print entry)
    (let* ((ext (file-name-extension
                 (url-unhex-string
                  (car (url-path-and-query (url-generic-parse-url
                                            url-enclosure))))))
           (date (format-time-string
                  "%F" (elfeed-entry-date entry)))
           (feed (elfeed-feed-title (elfeed-entry-feed entry)))
           (title (elfeed-entry-title entry)))
      (format "%s.%s"
              (isp/elfeed-slugify (format "%s-%s-%s" date feed title))
              ext)))
  (defvar elfeed-default-enclosure-directory "~/Podcasts/")
  (defun elfeed--request-enclosure-path (fname _path)
    "Ask the user where to save FNAME (default is PATH/FNAME)."
    (let ((fpath (expand-file-name
                  (read-file-name "Save as: " elfeed-default-enclosure-directory nil nil fname)
                  elfeed-default-enclosure-directory)))
      (if (file-directory-p fpath)
          (expand-file-name fname fpath)
        fpath)))
  (setq elfeed-show-enclosure-filename-function #'isp/elfeed-show-enclosure-filename-remote)
  (setq-default elfeed-search-filter "@1-week-ago -longform +unread ")
  (add-hook 'elfeed-new-entry-hook #'isp/elfeed-postcast-tagger))
