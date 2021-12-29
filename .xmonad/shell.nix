{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865" }:
let
  inherit (nixpkgs) pkgs;
  ghc = pkgs.haskell.packages.${compiler}.ghcWithPackages (ps: with ps; [
    xmonad
    xmonad-contrib
    xmonad-extras
    yeganesh
  ]);
in
  pkgs.stdenv.mkDerivation {
    name = "my-haskell-env-0";
    buildInputs = [ ghc ];
    shellHook = "eval $(egrep ^export ${ghc}/bin/ghc)";
  }

