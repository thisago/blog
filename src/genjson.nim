from std/os import createDir, `/`, splitFile, getLastModificationTime
from std/strutils import contains, replace
from std/json import `$`, `%*`, `%`
from std/times import toUnix, toTime

from blogpkg/incl/getPosts import getAllPosts
from blogpkg/incl/postName import toPostName
from blogpkg/incl/postDescription import genPostDescription
from blogpkg/incl/config import publicDir, pagesDir, outJsonFile, blogUrl
from blogpkg/incl/gitDt import gitFileLastModified, gitFileCreation, prettyDt

createDir publicDir

type
  Post = object
    name, description, url: string
    createdAt, modifiedAt: int64 # unixTime

# Generate a post list in a JSON

var posts: seq[Post]

for filename in getAllPosts pagesDir:
  let f = splitFile filename
  if f.name notin ["genpages", "index"] and "incl" notin f.dir:
    let
      nimFile = filename & ".nim"
      path = (proc: string =
        let f = filename.replace(pagesDir, "").splitFile
        f.dir / f.name & ".html"
      )()
        
    posts.add Post(
      name: nimFile.toPostName,
      description: genPostDescription readFile nimfile,
      url: blogUrl & path,
      createdAt: nimFile.gitFileCreation.toTime.toUnix,
      modifiedAt: nimFile.gitFileLastModified.toTime.toUnix
    )

(publicDir / outJsonFile).writeFile($ %*posts)
