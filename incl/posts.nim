from std/os import splitFile, `/`, relativePath

import pkg/nimib

from ./config import siteName
from ./postName import toPostName

const
  externalIcon* = "<sup style=\"font-size:0.7em\">↗</sup>"

template post*(body: untyped): untyped =
  let
    filename = instantiationInfo(-1, true).filename
    f = splitFile filename
    rel = filename.relativePath "."
  nbInit(
    thisFileRel = rel
  )
  nb.darkMode
  nb.context["favicon"] = """<link rel="icon" href="https://avatars.githubusercontent.com/u/74574275?s=48&v=4">"""
  nb.title = filename.toPostName & " - " & siteName
  body
  nbSave
