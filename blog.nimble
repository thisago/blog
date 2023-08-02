# Package

version       = "0.1.0"
author        = "Thiago Navarro"
description   = "thisago's blog"
license       = "GPL-3.0"
srcDir        = "src"
bin           = @["genpages", "gencss", "genjson"]

binDir = "build"

# Dependencies

requires "nim >= 1.6.4"

# base
requires "nimib"
requires "karax"
requires "sass"
requires "util"

# post specific
requires "htmlAntiCopy"

task runAll, "Builds and run all":
  for file in bin:
    exec "nimble --silent run " & file
