(* Imports *)
Require Import Mod1.

Require Import Coq.Arith.EqNat.

(* Extraction options *)
Extraction Language Haskell.
Set Extraction AutoInline.
Set Extraction Optimize.

(* Type/function extraction *)
Extract Inductive unit    => "()"             ["()"].
Extract Inductive bool    => "Prelude.Bool"   ["Prelude.True" "Prelude.False"].
Extract Inductive sumbool => "Prelude.Bool"   ["Prelude.True" "Prelude.False"].
Extract Inductive sum     => "Prelude.Either" ["Prelude.Left" "Prelude.Right"].
Extract Inductive list    => "[]"             ["[]" "(:)"].
Extract Inductive prod    => "(,)" ["(,)"].
Extract Inductive sigT    => "(,)" ["(,)"].
Extract Inductive option  => "Prelude.Maybe" ["Prelude.Just" "Prelude.Nothing"].
Extract Inductive sumor   => "Prelude.Maybe" ["Prelude.Just" "Prelude.Nothing"].
Extract Inductive comparison =>
  "Prelude.Ordering" ["Prelude.LT" "Prelude.EQ" "Prelude.GT"].

Extract Inductive Datatypes.nat => "Prelude.Integer" ["0" "Prelude.succ"].

Extract Inlined Constant andb       => "(Prelude.&&)".
Extract Inlined Constant app        => "(Prelude.++)".
Extract Inlined Constant beq_nat    => "(Prelude.==)".
Extract Inlined Constant fst        => "(Prelude.fst)".
Extract Inlined Constant length     => "(Data.List.length)".
Extract Inlined Constant minus      => "(Prelude.-)".
Extract Inlined Constant mult       => "(Prelude.*)".
Extract Inlined Constant negb       => "(Prelude.not)".
Extract Inlined Constant orb        => "(Prelude.||)".
Extract Inlined Constant plus       => "(Prelude.+)".
Extract Inlined Constant proj1_sig  => "".
Extract Inlined Constant snd        => "(Prelude.snd)".

(* Extraction clauses *)
Extraction "driver/hs/Mod1.hs" Mod1.main.
