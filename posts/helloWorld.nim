from std/strutils import join
from std/strformat import fmt

import pkg/nimib

import incl/posts

nbInit

nbText fmt"""
# Hello World!
This is the first post of my blog!

## How it works?
This blog is generated directly from Nim code, thanks for [Nimib {externalIcon}](https://github.com/pietroppeter/nimib)!

You can see the source code at [thisago/blog {externalIcon}](https://github.com/thisago/blog)
"""

nbCode:
  # We can run code like in a Python notebook!
  var food = "apple"
  echo fmt"John ate " & food

nbText fmt"""
### Post name
The post name comes from filename, at [`incl/postName.nim` {externalIcon}](https://github.com/thisago/blog/blob/master/incl/postName.nim)
we have an proc that prettify the filename:"""

nbCode:
  from incl/postName import toPostName
  echo "myFirstPost".toPostName
  echo "myNewPost-partOne".toPostName

nbText """
### Generation
The file [`genpages.nim` {externalIcon}](https://github.com/thisago/blog/blob/master/genpages.nim)
compile and runs all posts and put then in `public/` dir.

## Finalization
That's it! Thanks for reading!
"""

nbSave
