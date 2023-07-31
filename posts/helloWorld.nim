from std/strutils import join
from std/strformat import fmt

import incl/postBase

post:
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
    echo "John ate " & food

  nbText fmt"""
### Post name
The post name comes from filename.  
The module [`incl/postName.nim` {externalIcon}](https://github.com/thisago/blog/blob/master/incl/postName.nim)
generates the post title from filename:"""

  nbCode:
    from incl/postName import toPostName
    echo "myFirstPost".toPostName
    echo "myNewPost-partOne".toPostName

  nbText fmt"""
### Generation
The file [`genpages.nim` {externalIcon}](https://github.com/thisago/blog/blob/master/genpages.nim)
compile and runs all posts and put then in `public/` dir.

## Outro
That's it! Thanks for reading!
"""
