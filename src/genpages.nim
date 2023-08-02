from std/os import execShellCmd, createDir, moveFile, `/`, splitFile
from std/strutils import contains, replace
from std/strformat import fmt

from blogpkg/incl/getPosts import getAllPosts
from blogpkg/incl/config import publicDir, pagesDir, postsDir

createDir publicDir

# build posts
for filename in getAllPosts pagesDir:
  let f = splitFile filename
  if f.name != "genpages" and "incl" notin f.dir:
    doAssert 0 == execShellCmd fmt"nim r {filename}"
    let cleanFilename = filename.replace(pagesDir, "")
    createDir publicDir / cleanFilename.splitFile.dir
    fmt"{filename}.html".moveFile publicDir / fmt"{cleanFilename}.html"
