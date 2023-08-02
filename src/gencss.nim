from std/os import `/`, createDir

from blogpkg/incl/config import pkgDir, cssDir, mainSassFile, publicDir,
                                outCssFile

import pkg/sass

const
  mainStyle = pkgDir / cssDir / mainSassFile
  outCss = publicDir / cssDir / outCssFile
createDir publicDir / cssDir
compileFile(mainStyle, outCss, outputStyle = Compressed)
