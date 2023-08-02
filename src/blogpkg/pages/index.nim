from std/os import splitFile, relativePath, getLastModificationTime
from std/strformat import fmt
from std/times import format
from std/strutils import replace

import pkg/nimib

from incl/getPosts import getAllPosts
from incl/postName import toPostName
from incl/config import postsDir, siteName, pagesDir
from incl/postDescription import genPostDescription

import incl/post

post:
  nbStaticKarax(tdiv):
    h1: text siteName
    p:
      text "Welcome to my blog! It's a WIP project, but with time, it will look cooler :)"
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
            span(class = "post_meta_modifiedAt"): text nimFile.getLastModificationTime.format "yyyy/MM/dd hh:mm:ss tt"
            # unfortunately Unix doesn't stores file creation date (https://unix.stackexchange.com/a/91201)
          h2(class = "post_title"):
            if f.dir.len > 0:
              tdiv(class = "post_title_category"):
                text getPostCategory fullpath
            a(href = fmt"{f.dir}/{f.name}.html"):
              text filepath.toPostName
          tdiv(class = "post_description"):
            italic:
              text genPostDescription readFile nimFile
