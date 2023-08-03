# Changelog

## 2023/08/03

- Removed index from posts JSON generation
- Added optional post specific generation for `genpages` app
- Getting creation and modification date with `git log`
- Added creation date in index and JSON
- Styling

## 2023/08/02

- Fixes at `projects/htmlAntiCopy`; Closes #6
- Deleted `.gitattributes`; Closes #4
- Fixed last modification label; Closes #2
- Added a list of ways to bypass `htmlAntiCopy`; Closes #5
- Added automatic build with Github Workflows
- Added posts JSON list for external implementation! Closes #1
- Edited `projects/htmlAntiCopy`
- Added "Why?" and "How it works?" section in `projects/htmlAntiCopy`
- Added `run_all_release` nimble task
- Added CNAME into master branch

## 2023/08/02

- Typo in index
- Added the content of post `projects/htmlAntiCopy`
- Increased description max len
- Description is now stripped

## 2023/08/01

- Replaced markdown texts to static Karax DSLs from index file!
- Reverted the post list order in index
- Added custom SASS styling
- Added nimble file
- Structured the project to look like a nimble package
- Added link into page header to go to current file source (if it's at GH)
- Renamed `incl/posts.nim` to `incl/post.nim`
- Added a better page styling
- Added same color theme of my portfolio
- Added automatic generated (dirty) description for posts
- Added auto category detector (the directories inside `src/blogpkg/pages/posts`)
- And more, this was the larger change at now

## 2023/07/31

- init
- Added hello world post
- Added config.nims correctly
- Added missing fmt in `posts/helloWorld.nim`
- Dark theme
- fixes in `posts/helloWorld.nim`
- Added post base file
- Added favicon
- Added page titles
- Added page template to apply same config
- Cleaned `incl/posts.nim`
- Added site name to pages title
