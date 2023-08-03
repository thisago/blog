from std/strformat import fmt
from std/strutils import strip
from std/osproc import execCmdEx
from std/times import parse, format, DateTime

const
  outTimeFormat = "yyyy/MM/dd hh:mm:ss tt"
  gitTimeFormat = "yyyy-MM-dd HH:mm:ss '+0000'"

proc parseGitDate(s: string): DateTime =
  # .replace(" +0000", "").strip
  s.strip.parse gitTimeFormat

proc prettyDt*(s: DateTime): string =
  s.format outTimeFormat

proc gitFileLastModified*(f: string): DateTime =
  ## Gets the last modification date of a file in Git repository
  fmt"git log -1 --format=%ci '{f}'".execCmdEx.output.parseGitDate

proc gitFileCreation*(f: string): DateTime =
  ## Gets the creation date of a file in Git repository
  fmt"git log --format=%ci '{f}' | tail -1".execCmdEx.output.parseGitDate
