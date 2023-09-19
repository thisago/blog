from std/strformat import fmt

import pkg/nimib

import pkg/iecook

import incl/post

post:
  nbText fmt"""
# iecook
Hi again, have you ever needed to get the browser session automatically?  
Well, now with `httpOnly` option for cookies, makes harder to do this task, since
it aren't available to Javascript read and write.

When developing integrations with some private APIs with reverse engineer, I
faced this issue.

One example is my [Google Bard batchexecute API implementation](https://github.com/thisago/bard),
this library uses an session cookie (`__Secure-1PSIDTS`) that expires after some
usage, but since I needed to make it fully automatic, I created **iecook**.

The first need was get Google session cookies, that's why it was previously
called [Gookie](https://github.com/thisago/iecook/tree/9fb64ef5aafe0fadeb399245aec523326055f440)

But now, iecook, can get the cookies from any website, just import it:
"""
  nbCodeSkip:
    import pkg/iecook
  nbText fmt"And run:"
  nbCodeSkip:
    let allCookies = iecook "https://example.com"

  nbText fmt"""The proc `iecook` returns to you all cookies of all browser's
contexts (containers). And in chrome, since there's no multiple containers like
in Firefox, just a default container is returned.
"""
  var allCookies: IeCookList = @[
    ("firefox-container-1", @[
      ("session", "psRXXrIDRCWlfyGnf1RA"),
      ("userId", "5235"),
    ]),
    ("firefox-container-2", @[
      ("session", "2lgScP6s5wMHGzJn3m8J"),
      ("userId", "6784"),
      ("anotherOne", "Hello World! Again")
    ])
  ]
  nbCode:
    for (context, cookies) in allCookies:
      echo fmt"Got {cookies.len} cookies from {context}: '{cookies}'"
  nbText fmt"""
## How it works?
As said before, most of Javascript contexts haven't access to `httpOnly` cookies,
even in a userscript.  
But extensions can access it.

This library, basically opens a HTTP server that have just two routes. One to
provide the requested domain and other to receive the cookies.
the extension tries to request the domain all the time, and when server is opened,
it retrieve the cookies of all contexts and sends to you.

When server receives the cookies, it closes the server and return it to you.

## Should I use this?
This is a workaround, a dirty workaround. In order to this solution works, you
need to keep open your web browser with **iecook** installed and your application
will freeze until receive the cookies.

This isn't a solution for production and keep in mind that is potentially
dangerous keeping installed the client extension, because a malicious application
can request your cookies without your consent.

## Project using it
An project that uses **iecook** to get Cookies is [clibard](https://github.com/thisago/clibard),
an Google Bard CLI chat that uses the Google Bard private API

## Why iecook as name?
This name is just **cook**ie with the `ie` moved  to start. There's no extra
meaning :)

## Outro
Thanks for reading, if you want to read more and try by yourself, continue reading
at [iecook repository](https://github.com/thisago/iecook).
"""
