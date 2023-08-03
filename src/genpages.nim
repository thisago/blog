from std/os import execShellCmd, createDir, moveFile, `/`, splitFile,
                    commandLineParams
from std/strutils import contains, replace, join
from std/strformat import fmt

from blogpkg/incl/getPosts import getAllPosts
from blogpkg/incl/config import publicDir, pagesDir, postsDir

createDir publicDir

let postNames = commandLineParams()
if postNames.len > 0:
  echo fmt"Generating just: " & postNames.join ", "

# build posts
for filename in getAllPosts pagesDir:
  let f = splitFile filename
  if f.name != "genpages" and "incl" notin f.dir:
    if postNames.len > 0:
      if f.name notin postNames:
        continue
    echo fmt"Generating '{filename}'"
    doAssert 0 == execShellCmd fmt"nim r {filename}"
    let cleanFilename = filename.replace(pagesDir, "")
    createDir publicDir / cleanFilename.splitFile.dir
    fmt"{filename}.html".moveFile publicDir / fmt"{cleanFilename}.html"
