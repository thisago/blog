from std/os import splitFile, `/`, relativePath

import pkg/nimib

from ./postName import toPostName

const
  externalIcon* = "<sup style=\"font-size:0.7em\">↗</sup>"

template setup*(nb: NbDoc): untyped =
  let filename = instantiationInfo(-1, true).filename
  nb.darkMode
  nb.context["favicon"] = """<link rel="icon" href="https://avatars.githubusercontent.com/u/74574275?s=48&v=4">"""
  nb.title = filename.toPostName

template post*(body: untyped): untyped =
  let
    filename = instantiationInfo(-1, true).filename
    f = splitFile filename
    rel = filename.relativePath "."
  echo filename
  nbInit(
    thisFileRel = rel
  )
  nb.darkMode
  nb.context["favicon"] = """<link rel="icon" href="https://avatars.githubusercontent.com/u/74574275?s=48&v=4">"""
  nb.title = filename.toPostName
  body
  nbSave
