(* Imports *)
Require Import Mod1.

(* Extraction options *)
Extraction Language Scheme.
Set Extraction AutoInline.
Set Extraction Optimize.

(* Type/function extraction *)
(* TODO FIXME *)

(* Extraction clauses *)
Extraction "driver/scm/mod1.scm" Mod1.main.
