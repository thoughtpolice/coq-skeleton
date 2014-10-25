{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "coq-skeleton";
  buildInputs = [ coq ocaml utillinux ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${toString <nixpkgs>}"
  '';
}
