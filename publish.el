(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install htmlize for syntax highlighting
(unless (package-installed-p 'htmlize)
  (package-install 'htmlize))
;; Install ox-rss for RSS feed generation
(unless (package-installed-p 'ox-rss)
  (package-install 'ox-rss))

(require 'org)

;; Enable syntax highlighting
(setq org-src-fontify-natively t)

;; Load the publishing system
(require 'ox-publish)

;; Build SASS
(defun build-sass (main-file output-file)
  "Build SASS MAIN-FILE using the command line into OUTPUT-FILE."
  (unless (executable-find "sass")
    (error "SASS is not installed or not in your PATH"))
  (make-directory (file-name-directory output-file) t)
  (shell-command (format "sass --no-source-map -s compressed %s %s" main-file output-file)))
(build-sass "theme/index.sass" "public/theme/style.css")

(defun read-file (filename)
  "Read the contents of the FILENAME and return it as a string."
  (with-temp-buffer
    (insert-file-contents filename)
    (buffer-string)))

;; Customize the HTML output
(setq org-html-head-include-default-style nil
      org-html-head (read-file "templates/head.html")
      org-html-preamble (read-file "templates/preamble.html")
      org-html-postamble (read-file "templates/postamble.html"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (dot . t)
   (calc . t)
   (org . t)))

(setq
 org-html-doctype "html5"
 org-confirm-babel-evaluate nil
 make-backup-files nil
 org-src-fontify-natively t
 org-publish-project-alist '(("org-site:main"
                              :recursive t
                              :base-directory "./posts"
                              :publishing-function (org-html-publish-to-html)
                              :publishing-directory "./public"
                              :exclude "drafts"
                              :with-author nil
                              :with-toc t
                              :time-stamp-file t
                              :section-numbers nil
                              :auto-sitemap t
                              :sitemap-filename "index.org"
                              :sitemap-title "Posts"
                              :with-timestamps nil
                              :time-stamp-file nil
                              :with-footnotes t)
                             ("homepage_rss"
                              :base-directory "./posts"
                              :base-extension "org"
                              ;; :rss-image-url "http://lumiere.ens.fr/~guerry/images/faces/15.png"
                              :html-link-home "http://blog.thisago.com/"
                              :html-link-use-abs-url t
                              :rss-extension "xml"
                              :publishing-directory "./public"
                              :publishing-function (org-rss-publish-to-rss)
                              :section-numbers nil
                              :exclude ".*"            ;; To exclude all files...
                              :include ("index.org")   ;; ... except index.org.
                              :table-of-contents nil)))

(org-publish-all t)

;; Write CNAME
(with-temp-file "public/CNAME"
  (insert "blog.thisago.com"))

(message "Build complete!")
