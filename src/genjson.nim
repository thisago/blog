from std/os import createDir, `/`, splitFile, getLastModificationTime
from std/strutils import contains, replace
from std/json import `$`, `%*`, `%`
from std/times import toUnix

from blogpkg/incl/getPosts import getAllPosts
from blogpkg/incl/postName import toPostName
from blogpkg/incl/postDescription import genPostDescription
from blogpkg/incl/config import publicDir, pagesDir, outJsonFile, blogUrl

createDir publicDir

type
  Post = object
    name, description, url: string
    modifiedAt: int64 # unixTime

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
      modifiedAt: nimFile.getLastModificationTime.toUnix
    )

(publicDir / outJsonFile).writeFile($ %*posts)
