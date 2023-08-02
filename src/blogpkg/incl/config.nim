from std/os import `/`

const
  publicDir* = "public"
  cssDir* = "style"
  mainSassFile* = "main.sass"
  outCssFile* = "main.css"
  outJsonFile* = "posts.json"
  pkgDir* = "src/blogpkg"
  pagesDir* = pkgDir / "pages"
  postsDir* = pagesDir / "posts"
  siteName* = "thisago's blog"
  blogUrl* = "https://blog.thisago.com" # no end slash
