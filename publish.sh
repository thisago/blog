#!/usr/bin/env sh
":"; exec emacs --quick --script "$0" -- "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-

;; Stolen from: https://github.com/SystemCrafters/org-website-example/blob/1ee251e97f5b4d6c614936030203cd7368d4adc8/build-site.el

;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)


;; Stolen from: https://orgmode.org/worg/org-site-colophon.html

(require 'ox)
(require 'ox-html)
(load "~/.emacs.d/.local/straight/repos/emacs-htmlize/htmlize.el" t t) ; system-dependant
(require 'htmlize)

(load "~/.emacs.d/.local/straight/repos/org-mode/contrib/lisp/ox-extra.el" t t)
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

(setq
 org-html-style-default ""
 org-html-scripts ""
 org-html-htmlize-output-type 'css
 org-html-doctype "html5"
 org-html-html5-fancy t
 org-html-validation-link nil
 org-html-postamble t
 org-html-postamble-format
 '(("en" "<p class=\"author\">Made with <a href=\"https://orgmode.org/worg/org-site-colophon.html\">🤎</a> by <a href=\"https://github.com/tecosaur/\" style=\"font-weight: bold; font-size: 0.9em; letter-spacing: 1px\">TEC</a></p>
<p xmlns:dct=\"http://purl.org/dc/terms/\" xmlns:cc=\"http://creativecommons.org/ns#\" class=\"license-text\" style=\"color: #aaa\">licensed under <a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/4.0/\"><img class=\"inline\" src=\"/resources/img/external/cc-by-sa.svg\" title=\"CC-BY-SA 4.0\" alt=\"CC-BY-SA\"/></a></p>"))
 make-backup-files nil
 debug-on-error t)

(let ((scss-files (directory-files-recursively default-directory "\\.scss$"))
      (org-files (directory-files-recursively default-directory "\\.org$")))
  (if (executable-find "sassc")
      (dolist (scss-file scss-files)
        (let ((sassc-out
               (shell-command-to-string
                (format "sassc %s %s"
                        scss-file (concat (file-name-sans-extension scss-file) ".css")))))
          (message "\033[0;35m• %s%s\033[0m" (file-relative-name scss-file default-directory)
                   (if (string= "" sassc-out) "" (concat ":\033[31m\n" sassc-out)))))
    (message "No sassc executable found"))
  (dolist (org-file org-files)
    (message "\033[0;34m• %s\033[90m" (file-relative-name org-file default-directory))
    (with-current-buffer (find-file-literally org-file)
      (condition-case err
          (progn (org-html-export-to-html)
                 (htmlize-file org-file (concat org-file ".html")))
        (error (message "  \033[0;31m%s\033[90m"  (error-message-string err)))))))
(message "\033[0m")
(kill-emacs 0)
