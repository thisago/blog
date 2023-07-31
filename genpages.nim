#!/bin/env -S nim r genpages.nim
from std/os import execShellCmd, createDir, moveFile, `/`, splitFile
from std/strutils import contains
from std/strformat import fmt

from incl/getPosts import getAllPosts
from incl/config import publicDir

createDir publicDir

for file in getAllPosts ".":
  let f = splitFile file
  if f.name != "genpages" and "incl" notin f.dir:
    doAssert 0 == execShellCmd fmt"nim r {file}"
    let htmlOut = fmt"{file}.html"
    createDir publicDir / f.dir
    moveFile htmlOut, publicDir / htmlOut
