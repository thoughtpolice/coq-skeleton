(* Imports *)
Require Import SfLib.
Require Import String.
Require Import Ascii.
Require Import EqNat.

Require Import Mod1.

(* Extraction options *)
Unset Extraction KeepSingleton.
Extraction Language Haskell.
Set Extraction AutoInline.
Set Extraction Optimize.
Set Extraction AccessOpaque.

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
Extract Inductive string  => "Prelude.String" ["[]" "(:)"].
Extract Inductive comparison =>
  "Prelude.Ordering" ["Prelude.LT" "Prelude.EQ" "Prelude.GT"].
Extract Inductive Datatypes.nat => "Prelude.Integer" ["0" "Prelude.succ"]
  "(\fO fS n -> if n Prelude.== 0 then fO () else fS (n Prelude.- 1))".

Extract Inductive ascii => "Prelude.Char"
[ "{-- If this appears, you're using Ascii internals. Please don't --}
   (\b0 b1 b2 b3 b4 b5 b6 b7 ->
     let f b i = if b then Data.Bits.shiftL 1 (Prelude.fromIntegral i) else 0
     in Data.Char.chr (f b0 0 Prelude.+ f b1 1 Prelude.+ f b2 2 Prelude.+ f b3 3 Prelude.+ f b4 4 Prelude.+ f b5 5 Prelude.+ f b6 6 Prelude.+ f b7 7))"
]
"{-- If this appears, you're using Ascii internals. Please don't --}
 (\f c ->
   let n   = Data.Char.ord c
       h i = (Data.Bits..&.) n (Data.Bits.shiftL 1 (Prelude.fromIntegral i)) Prelude./= 0
   in f (h 0) (h 1) (h 2) (h 3) (h 4) (h 5) (h 6) (h 7))
".

Extract Inlined Constant zero       => "'\000'".
Extract Inlined Constant one        => "'\001'".
Extract Constant shift =>
  "(\b c -> Data.Char.chr $
     let x = Data.Bits.shiftL (Data.Char.ord c) 1
         y = Data.Bits..&. x 255
         z = if b then 1 else 0
     in y + z))".

Extract Inlined Constant ascii_dec  => "(==)".

Extract Inlined Constant andb       => "(Prelude.&&)".
Extract Inlined Constant app        => "(Prelude.++)".
Extract Inlined Constant beq_nat    => "(Prelude.==)".
Extract Inlined Constant ble_nat    => "(Prelude.<=)".
Extract Inlined Constant fst        => "(Prelude.fst)".
Extract Inlined Constant length     => "(Data.List.length)".
Extract Inlined Constant minus      => "(Prelude.-)".
Extract Inlined Constant mult       => "(Prelude.*)".
Extract Inlined Constant max        => "(Prelude.max)".
Extract Inlined Constant min        => "(Prelude.min)".
Extract Inlined Constant negb       => "(Prelude.not)".
Extract Inlined Constant orb        => "(Prelude.||)".
Extract Inlined Constant plus       => "(Prelude.+)".
Extract Inlined Constant map        => "(Prelude.map)".
Extract Inlined Constant proj1_sig  => "".
Extract Inlined Constant snd        => "(Prelude.snd)".
Extract Inlined Constant fold_right => "(Prelude.foldr)".
Extract Inlined Constant rev        => "(Prelude.reverse)".
Extract Inlined Constant nat_of_ascii =>
  "(\x -> Prelude.fromIntegral (Data.Char.ord x))".

(* Extraction clauses *)
Extraction "driver/hs/Mod1.hs" Mod1.main.
