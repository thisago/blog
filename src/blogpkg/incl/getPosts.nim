from std/os import walkDirRec, pcFile, splitFile, `/`

proc getAllPosts*(postsDir: string): seq[string] =
  for file in walkDirRec postsDir:
    let f = splitFile file
    if f.ext == ".nim":
      result.add f.dir / f.name
