# Basic Haskell Examples
Copyright © 2015 Bart Massey

The Haskell examples here are intended for beginners. The
problems are from Gabriel Gonzalez
<http://www.haskellforall.com/2015/10/basic-haskell-examples.html>;
the solutions are mostly by me.

* `todo.hs`: TODO List (problem: Gonzalez (#1), solution: Massey)

  Interactively process a list of commands to maintain an
  in-memory TODO list. Tough one to start with when teaching
  Haskell.

* `tabcomma.hs`: Tab-Separated Values -> CSV (problem:
  Gonzalez (#2), solution: Massey)

  Replace all tabs with commas while translating standard
  input to standard output.

* `tabcomma2.hs`: Tab-Separated Values -> CSV (problem:
  Gonzalez (#2), solution: Massey)

  Do full TSV->CSV with quoting and escaping.  Requires the
  `ssv` package from Hackage.

* `calendar2015.hs`: Print 2015 Calendar (problem:
  Gonzalez (#3), solution: Massey)

  Print an ASCII 2015 calendar on standard output.

* `rna.hs`: Decode RNA (problem: Gonzalez (#4), solution:
  Gonzalez)

  Makes pretty (though verbose) of `deriving` and pattern
  matching to decode RNA to amino acids using a hard-coded
  table.

* `rna2.hs`: Decode RNA (problem: Gonzalez (#4), solution:
  Massey)

  Simple solution using a separate table file `rna.txt`.

* `bedtime.hs`: Bedtime Story (problem: Gonzalez (#5),
  solution: Massey)

  Madlib-style bedtime story generator exhibiting the use of
  the list monad and user-defined operators.

* `bedtime2.hs`: Bedtime Story (problem: Gonzalez (#5),
  solution: Massey)

  Uses typeclasses to simplify (?) story writing. Also
  word-wraps the story into 60-column lines. Maybe not
  so "basic".

This work is released under the 2-clause BSD license. See
the file `COPYING` in this distribution for license terms.
Work by Gabriel Gonzalez is used without express permission.
