# wlox

A [wren](wren) implementation of both [jlox](lox) and [clox](lox)

This implementation follows the progress of the book [Crafting Interpreters](lox), rather than trying to port the whole thing at once, mainly because I don't have much free time.

I'm trying to make the code less javic, and more wren-esq, but I won't get it right the first time: PRs, Issues, suggestions welcome.

The repo is divided up into a hierarchy of folder that match the chapters and subsections of [Crafting Interpreters](lox), Each new section the code from the previous folder is copied across and continued in the next folder. This isn't efficient, or smart, but it is simple, and allows for revisions of the past if the book changes.

[lox]: https://craftinginterpreters.com
[wren]: https://www.wren.io
