from std/strutils import toUpperAscii, toLowerAscii, Letters
from std/strformat import fmt
from std/os import splitFile

const UpperChars = {'A'..'Z'}

proc toPostName*(postPath: string): string =
  ## Generate a post name based in post filename:
  ##   - myNewPost -> My new post
  ##   - mySecondPost-starting -> My second post - Starting
  runnableExamples:
    doAssert "myNewPost".toPostName == "My new post"
    doAssert "mySecondPost-starting".toPostName == "My second post - Starting"
  var nextUpper = true
  for ch in postPath.splitFile.name:
    if nextUpper and ch in Letters:
      result.add ch.toUpperAscii
      nextUpper = false
    else:
      if ch in UpperChars:
        result.add fmt" {ch.toLowerAscii}"
      elif ch in Letters:
        result.add ch
      else:
        result.add fmt" {ch} "
        nextUpper = true

when isMainModule:
  echo "myNewPost".toPostName
  echo "mySecondPost-starting".toPostName
