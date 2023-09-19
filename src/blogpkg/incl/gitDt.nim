from std/strformat import fmt
from std/strutils import strip
from std/osproc import execCmdEx
from std/times import parse, format, DateTime, now

const
  outTimeFormat = "yyyy/MM/dd hh:mm:ss tt"
  gitTimeFormat = "yyyy-MM-dd HH:mm:ss"

proc parseGitDate(s: string): DateTime =
  # .replace(" +0000", "").strip
  s.strip[0..<s.len - 7].parse gitTimeFormat

proc prettyDt*(s: DateTime): string =
  s.format outTimeFormat

proc gitFileLastModified*(f: string): DateTime =
  ## Gets the last modification date of a file in Git repository
  let res = fmt"git log -1 --format=%ci '{f}'".execCmdEx.output
  result = if res.len > 0: parseGitDate res
           else: now()

proc gitFileCreation*(f: string): DateTime =
  ## Gets the creation date of a file in Git repository
  let res = fmt"git log --format=%ci '{f}' | tail -1".execCmdEx.output
  result = if res.len > 0: parseGitDate res
           else: now()
