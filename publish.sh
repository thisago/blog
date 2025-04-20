#!/usr/bin/env sh
":"; exec emacs --quick --script "$0" -- "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-

;; Stolen/Inspired from:
;; - https://github.com/SystemCrafters/org-website-example/blob/1ee251e97f5b4d6c614936030203cd7368d4adc8/build-site.el
;; - https://orgmode.org/worg/org-site-colophon.html

(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(unless (package-installed-p 'ox-gfm)
  (package-install 'ox-gfm))

(require 'ox)
(require 'ox-html)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   (dot . t)
   (clojure . t)
   (org . t)
   (ditaa . t)
   (org . t)
   (scheme . t)
   (plantuml . t)
   (R . t)
   (gnuplot . t)))

(setq
 org-html-style-default ""
 org-html-scripts ""
 org-html-doctype "html5"
 org-html-html5-fancy t
 org-html-validation-link nil
 ;; enable code block execution
 org-confirm-babel-evaluate nil
 make-backup-files nil
 debug-on-error t)

;; Colors
(setq
 color-red "\033[0;31m"
 color-green "\033[0;32m"
 color-yellow "\033[0;33m"
 color-blue "\033[0;34m"
 color-magenta "\033[0;35m"
 color-cyan "\033[0;36m"
 color-white "\033[0;37m"
 color-black "\033[0;30m"
 color-default "\033[0m")

(setq
 sass-exec "sass"
 sass-file-regex "\\.sass$"
 org-file-regex "\\.org$"
 sass-cmd (concat sass-exec " --no-source-map %s %s"))

(setq
 posts-dir "posts"
 sass-dir "theme")

(let ((sass-files (directory-files-recursively
                   (concat default-directory sass-dir) sass-file-regex))
      (org-files (directory-files-recursively
                  (concat default-directory posts-dir) org-file-regex)))

  (message (concat color-blue "Processing sass files..." color-default))
  (if (executable-find sass-exec)
      (dolist (sass-file sass-files)
        (let ((sassc-out (shell-command-to-string
                          (format sass-cmd sass-file (concat (file-name-sans-extension sass-file) ".css")))))
          (message (concat "- " color-green "%s%s" color-default) (file-relative-name sass-file default-directory)
                   (if (string= "" sassc-out) "" (concat ":" color-red "\n" sassc-out)))))
    (message (concat color-red "No sass executable found" color-default)))

  (message (concat color-blue "Processing org files..." color-default))
  (dolist (org-file org-files)
    (with-current-buffer (find-file-literally org-file)
      (condition-case err
          (progn (org-gfm-export-to-markdown)
                 (message (concat "- " color-green "%s" color-default) (file-relative-name org-file default-directory)))
        (error (message (concat color-red "%s" color-default)  (error-message-string err)))))))

(kill-emacs 0)
