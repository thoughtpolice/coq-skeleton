# Coq project skeleton

This is a simple skeleton to get started writing [Coq][coq] projects,
with support for `Makefile` and [Proof General][pg] development, and
easy extraction capabilities to OCaml.

To get started:

  1. Replace the first line of `_CoqProject` from `-R . Skeleton` to
     `-R . YourName`, where `YourName` is whatever you desire for the
     logical name of the project (for example: `ComplexNumberLib`).
  2. Make the same change in `.dir-locals.el` (needed for Proof General).
  3. Run `make` to compile the example theories, and `make extract` to
     extract the example `main` in `Mod1` to OCaml code.

Next, when you add or delete any modules, just them to `_CoqProject`
in whatever order you like. The `Makefile` will figure out the
dependencies automatically.

If you don't need extraction, you can delete remove `./Extract.v` from
`_CoqProject`. The automated support for extraction is minimal; see
the `extract` target in the `Makefile` for more.

[Proof General][pg] 4.2 or later should work out of the box - simply
open any file like `Mod1`, begin editing, and start stepping through
code. You're encouraged to enable 'Electric Terminator' mode for speed
of development (via `C-c .`).

As a convenience, this skeleton includes the `CpdtTactics` module from
Adam Chlipala's book '[Certified Programming with Dependent
Types][cpdt]', as well as the `SfLib` module from Benjamin Pierce's
'[Software Foundations][sf]' book.

[coq]:  http://coq.inria.fr/
[pg]:   http://proofgeneral.inf.ed.ac.uk/
[cpdt]: http://adam.chlipala.net/cpdt/
[sf]:   http://www.cis.upenn.edu/~bcpierce/sf/current/index.html