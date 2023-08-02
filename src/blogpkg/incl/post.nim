from std/os import splitFile, `/`, relativePath, getCurrentDir
from std/strutils import split, repeat, replace

import pkg/nimib
from pkg/nimib/themes import waterDark
import pkg/karax/[karaxdsl, vdom]
export karaxdsl, vdom

from ./config import siteName, cssDir, outCssFile, pagesDir
from ./postName import toPostName

const
  externalIcon* = "<sup style=\"font-size:0.7em\">↗</sup>"

proc getPostCategory*(postPath: string): string =
  ## Gets the path of post relative to `src/blogpkg/pages/posts`
  result = postPath.relativePath(getCurrentDir()).replace(pagesDir, "").relativePath("/posts").splitFile.dir
  if result == "..":
    result = ""

proc categoryTitle*(filename: string): string =
  ## Creates an category title
  let category = filename.getPostCategory
  if category.len > 0:
    result = "<h4 class=\"category\">" & category & "</h4>"

template post*(body: untyped): untyped =
  let
    filename = instantiationInfo(-1, true).filename
    f = splitFile filename
    rel = filename.relativePath "."
  nbInit(
    thisFileRel = rel
  )
  darkMode nb

  # get back path to public dir
  var backToRoot = ""
  let relExtraLevels = rel.splitFile.dir.replace(pagesDir, "").split("/").len - 1
  if relExtraLevels > 0:
    backToRoot = "../".repeat relExtraLevels 

  nb.context["favicon"] = """<link rel="icon" href="https://avatars.githubusercontent.com/u/74574275?s=48&v=4">"""
  nb.context["stylesheet"] = waterDark & "<link rel=\"stylesheet\" href=\"" & backToRoot / cssDir / outCssFile & "\" />"
  let
    title = nb.context["title"].castStr
    ghUrl = nb.context["github_remote_url"].castStr
  if ghUrl.len > 0:
    nb.partials["header_center"] = "<a target=\"_blank\" rel=\"noopener noreferrer\" href=\"" &
                                    ghUrl & "/tree/master/" & title & "\"><code>" &
                                    title & "</code></a>"
  nb.title = filename.toPostName & " - " & siteName

  nbText categoryTitle filename
  body

  nbSave

template nbStaticKarax*(baseEl, body: untyped) =
  let vnode = buildHtml(baseEl):
    body
  nbText $vnode
