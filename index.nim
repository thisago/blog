from std/strformat import fmt

import pkg/nimib

from incl/getPosts import getAllPosts
from incl/postName import toPostName
from incl/config import postsDir, siteName

import incl/posts

post:
  nbText fmt"# {siteName}"
  nbText "## Posts"

  for post in getAllposts postsDir:
    nbText fmt"### [{post.toPostName}]({post}.html)"
    # TODO: Add creation and modification date for each post
