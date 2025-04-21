;;; publish.el --- thisago's blog -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025
;;
;; Author:  <thisago@disroot.org>
;; Maintainer:  <thisago@disroot.org>
;; Created: April 21, 2025
;; Modified: April 21, 2025
;; Version: 0.0.1
;; Keywords: blog
;; Homepage: https://thisago.com
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Stolen/Inspired from:
;; - https://github.com/SystemCrafters/org-website-example/blob/1ee251e97f5b4d6c614936030203cd7368d4adc8/build-site.el
;; - https://orgmode.org/worg/org-site-colophon.html
;
;;
;;; Code:

(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(unless (package-installed-p 'org-static-blog)
  (package-install 'org-static-blog))

(setq org-static-blog-publish-title "thisago's blog")
(setq org-static-blog-publish-url "https://thisago.com")
(setq org-static-blog-publish-directory "~/Documents/repos/blog/static/")
(setq org-static-blog-posts-directory "~/Documents/repos/blog/posts/")
(setq org-static-blog-drafts-directory "~/Documents/repos/blog/drafts/")
(setq org-static-blog-enable-tags t)
(setq org-export-with-toc nil)
(setq org-export-with-section-numbers nil)

;; This header is inserted into the <head> section of every page:
;;   (you will need to create the style sheet at
;;    ~/projects/blog/static/style.css
;;    and the favicon at
;;    ~/projects/blog/static/favicon.ico)

(setq
 head-author "thisago"
 head-description "thisago's blog"
 head-viewport "width=device-width, initial-scale=1.0"
 head-stylesheet "static/style.css"
 head-icon "static/favicon.ico")

(setq org-static-blog-page-header
      (concat
       "<meta name=\"author\" content=\"" head-author "\">"
       "<meta name=\"referrer\" content=\"no-referrer\">"
       "<meta name=\"viewport\" content=\"" head-viewport "\">"
       "<link href=\"" head-stylesheet "\" rel=\"stylesheet\" type=\"text/css\" />"
       "<link rel=\"icon\" href=\"" head-icon "\"/>"))

;; This preamble is inserted at the beginning of the <body> of every page:
;;   This particular HTML creates a <div> with a simple linked headline
(setq org-static-blog-page-preamble
      (concat
       "<div class=\"header\">
          <a href=\"" org-static-blog-publish-url "\">My Static Org Blog</a>
        </div>"))

;; This postamble is inserted at the end of the <body> of every page:
;;   This particular HTML creates a <div> with a link to the archive page
;;   and a licensing stub.
(setq org-static-blog-page-postamble
      "<div id=\"archive\">
       <a href=\"https://staticblog.org/archive.html\">Other posts</a>
     </div>
     <center><a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/3.0/\"><img alt=\"Creative Commons License\" style=\"border-width:0\" src=\"https://i.creativecommons.org/l/by-sa/3.0/88x31.png\" /></a><br /><span xmlns:dct=\"https://purl.org/dc/terms/\" href=\"https://purl.org/dc/dcmitype/Text\" property=\"dct:title\" rel=\"dct:type\">bastibe.de</span> by <a xmlns:cc=\"https://creativecommons.org/ns#\" href=\"https://bastibe.de\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">Bastian Bechtold</a> is licensed under a <a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/3.0/\">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.</center>")

;; This HTML code is inserted into the index page between the preamble and
;;   the blog posts
(setq org-static-blog-index-front-matter
      "<h1> Welcome to my blog </h1>\n")

(provide 'publish)
;;; publish.el ends here
