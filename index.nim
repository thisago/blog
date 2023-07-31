from std/strformat import fmt

import pkg/nimib

from incl/getPosts import getAllPosts
from incl/postName import toPostName
from incl/config import postsDir

nbInit

nbText "# thisago's blog"
nbText "## Posts"

for post in getAllposts postsDir:
  nbText fmt"- [{post.toPostName}]({post}.html)"

nbSave
