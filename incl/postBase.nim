import pkg/nimib
export nimib

const
  externalIcon* = "<sup style=\"font-size:0.7em\">↗</sup>"

template post*(body: untyped): untyped {.dirty.} =
  nbInit()
  nb.darkMode
  body
  nbSave
  