{ pkgs ? import <nixpkgs> {} }:
let myGhc = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
      turtle
      regex-tdfa
    ]);
in
pkgs.mkShell {
  buildInputs = [ myGhc ];
}