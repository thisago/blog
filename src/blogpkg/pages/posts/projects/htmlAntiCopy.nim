from std/strformat import fmt

import pkg/nimib

import incl/post

from pkg/htmlAntiCopy import shuffle, toHtml

post:
  nbText """# Html Anti Copy
In this post we'll see in action an library that prohibits you to copy HTML
text, even on devtools!

See this example, try to copy the following text:
> """ & shuffle("Hello World! XD").toHtml

  nbText """---
Such interesting right?

**Let's see how to reproduce**

To generate a shuffled text like above is very simple, just call `shuffle`, let's see:
"""
  nbCode:
    import pkg/htmlAntiCopy
    let shuffled = shuffle "Try to copy me! Let's see if you're a real hacker :P"

  nbText "But now we need an usable output, so we can use `toHtml`:"

  nbCodeSkip:
    let html = shuffled.toHtml
    echo html

  var html = "Try to copy me! Let's see if you're a real hacker :P".shuffle.toHtml
  nbText fmt"<pre>{html}</pre>"

  nbText """Easy as that!

## Why?
This method doesn't block expert users to copy, it's intended to prevent bots
and regular users to copy some text content.

## How it works?
Now you may be curious to see how it works, right? **So let's check it out!**

The output of this program is an HTML, as you saw in the name, here's an small
example of an possible output for shuffling "Hi":
```html
<style>
  div.abc i:nth-child(2) {
    font-size: 0;
  }
</style>
<div class="abc">
  <i>H</i>
  <i>l</i>
  <i>i</i>
</div>
```
So, what it does is add random chars inside the text and wrap each char in a
`italic` element inside a container with a random class, because the tag name is small.  
Then an CSS hides the random generated chars by index!

It's also possible to increase "shuffle level" to increase the random chars in
the text!

Let's increase a _little bit_!
"""

  nbCodeSkip:
    let
      newShuffled = "How much text in me?".shuffle 20
      newHtml = newShuffled.toHtml
    echo newHtml

  html = "How much text in me?".shuffle(20).toHtml
  nbText fmt"<pre>{html}</pre>"


  nbText """---

## Fun time
Let's play a bit with this!
"""

  nbKaraxCode:
    from std/strutils import replace

    from pkg/htmlAntiCopy import antiCopy
    from pkg/util/forStr import tryParseInt

    var
      text = "Copy and edit me!"
      level = 1
      shuffledHtml = text.antiCopy(level)
      disableCss = false

    proc applyCssState =
      const
        enabledClass = "class=\""
        disabledClass = "class=\"-"
      shuffledHtml = cstring(
        if disableCss: shuffledHtml.`$`.replace(enabledClass, disabledClass)
        else: shuffledHtml.`$`.replace(disabledClass, enabledClass))

    karaxHtml:
      label:
        text "Text"
        input(value = text):
          proc onInput(ev: Event; n: VNode) =
            text = $n.value
      label:
        text "Shuffle level"
        input(value = $level, min = "0", max = "100", `type` = "number"):
          proc onInput(ev: Event; n: VNode) =
            level = tryParseInt $n.value
      button:
        text "Shuffle!"
        proc onClick =
          shuffledHtml = text.antiCopy level
          if disableCss:
            applyCssState()

      br()

      label:
        input(`type` = "checkbox", checked = toChecked disableCss):
          proc onChange(ev: Event; n: VNode) =
            disableCss = not disableCss
            applyCssState()
        text "Disable CSS"

      br()
      label:
        text "Output"
        tdiv(class = "htmlAntiCopy_output"):
          verbatim shuffledHtml

  nbText """---

## Can I bypass it?
Yes, every technology has a flaw, in this case, we saw that we choose which char
will be hid with CSS, so, in order to bypass it, you can parse the CSS selector
to get the random chars indexes and remove if from HTML.

But it's very specific, bots and common users wouldn't be able to copy.

Or just use OCR, but to try prevent it, the text needs to be partially unreadable
and this affects the user experience.

## Finalization
If you want to know more about this library, see the project repo at
[thisago/htmlAntiCopy](https://github.com/thisago/htmlAntiCopy)
"""
