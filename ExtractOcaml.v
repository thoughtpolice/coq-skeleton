(* Imports *)
Require Import Mod1.

Require Import ExtrOcamlBasic.
Require Import ExtrOcamlNatInt.
Require Import ExtrOcamlZInt.
Require Import ExtrOcamlString.

(* Extraction options *)
Extraction Language Ocaml.
Set Extraction AutoInline.
Set Extraction Optimize.

(* Type/function extraction *)
(* NOTE: Provided by 'ExtrOcaml' imports *)

(* Extraction clauses *)
Extraction "driver/ml/mod1.ml" Mod1.main.
