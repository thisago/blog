from std/strutils import Letters, Digits, Whitespace, strip
from pkg/util/forStr import getEnclosedText

const DescriptionChars = Letters + Digits + Whitespace

proc genPostDescription*(code: string; maxlen = 160): string =
  ## Creates an file description getting all strings of post XD
  for str in code.getEnclosedText(['"', '"']).texts:
    for ch in str:
      if ch in DescriptionChars:
        result.add ch
    result.add "  "
  result = strip result
  if result.len > maxlen:
    result = result[0..maxlen] & "..."

when isMainModule:
  echo genPostDescription """echo "# fake conversation"
echo "hello john!"
echo "hi tom!"
"""
