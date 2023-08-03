from std/os import splitFile, relativePath, getLastModificationTime
from std/strformat import fmt
from std/strutils import replace

import pkg/nimib

from incl/getPosts import getAllPosts
from incl/postName import toPostName
from incl/config import postsDir, siteName, pagesDir
from incl/postDescription import genPostDescription
from incl/gitDt import gitFileLastModified, gitFileCreation, prettyDt

import incl/post

post:
  nbStaticKarax(tdiv):
    h1: text siteName
    p: text "Welcome to my programming blog! ;)"
    h2: text "Posts"
    tdiv(class = "posts"):
      let allPosts = getAllposts postsDir
      for i in countdown(allPosts.len - 1, 0):
        let
          fullpath = allPosts[i]
          nimFile = fullpath & ".nim"
          filepath = fullpath.replace(pagesDir, "")
          f = splitFile "." & filepath
        tdiv(class = "post"):
          tdiv(class = "post_meta"):
            span(class = "post_meta_createdAt"):
              text prettyDt gitFileCreation nimFile
            span(class = "post_meta_modifiedAt"):
              text prettyDt gitFileLastModified nimFile
          h2(class = "post_title"):
            if f.dir.len > 0:
              tdiv(class = "post_title_category"):
                text getPostCategory fullpath
            a(href = fmt"{f.dir}/{f.name}.html"):
              text filepath.toPostName
          tdiv(class = "post_description"):
            italic:
              text genPostDescription readFile nimFile
