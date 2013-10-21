[![Build Status](https://secure.travis-ci.org/rolandwalker/simpleclip.png?branch=master)](http://travis-ci.org/rolandwalker/simpleclip)

Overview
========

Simplified access to the system clipboard in Emacs.

Quickstart
----------

```lisp
(require 'simpleclip)
 
(simpleclip-mode 1)
 
;; Press super-c to copy without affecting the kill ring.
;; Press super-x or super-v to cut or paste.
;; On OS X, use ⌘-c, ⌘-v, ⌘-x.
```

Explanation
-----------

By default, Emacs orchestrates a subtle interaction between the
internal kill ring and the external system clipboard.

`simpleclip-mode` radically simplifies clipboard handling: the
system clipboard and the Emacs kill ring are made completely
independent, and never influence each other.

`simpleclip-mode` also enables support for accessing the system
clipboard from a TTY where possible.  You will likely need to
set up custom keybindings if you want to take advantage of that.

To use simpleclip, place the simpleclip.el library somewhere
Emacs can find it, and add the following to your ~/.emacs file:

```lisp
(require 'simpleclip)
(simpleclip-mode 1)
```

Keybindings
-----------

Turning on `simpleclip-mode` activates clipboard-oriented key
bindings which are modifiable in customize.

The default bindings override keystrokes which may be bound as
alternatives for kill/yank commands on your system.  "Traditional"
kill/yank keys (control-k, control-y, meta-y) are unaffected.

The default keybindings are

	         super-c   simpleclip-copy
	         super-x   simpleclip-cut
	         super-v   simpleclip-paste

	control-<insert>   simpleclip-copy
	  shift-<delete>   simpleclip-cut
	  shift-<insert>   simpleclip-paste

The `super` keybindings are friendly for OS X.  The `insert`/`delete`
keybindings are better suited for Unix and MS Windows.

Notes
-----

`x-select-enable-primary` is not affected by `simpleclip-mode`.

Access to the system clipboard from a TTY is provided for those
cases where a literal paste is needed -- for example, where
autopair interferes with pasted input which is interpreted as
keystrokes.  If you are already happy with the copy/paste provided
by your terminal emulator, then you don't need to set up
simpleclip's TTY support.

The following functions may be useful to call from Lisp:

	simpleclip-get-contents
	simpleclip-set-contents

Compatibility and Requirements
------------------------------

	GNU Emacs version 24.4-devel     : yes, at the time of writing
	GNU Emacs version 24.3           : yes
	GNU Emacs version 23.3           : yes
	GNU Emacs version 22.2           : yes, with some limitations
	GNU Emacs version 21.x and lower : unknown

No external dependencies

Tested on OS X, X11, and MS Windows
