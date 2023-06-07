with (import <nixpkgs> {});


let
  ghcWithPkgs = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
      turtle
      regex-tdfa
  ]);
in 
mkShell {
  name = "haskell-shell";
  buildInputs = [ ghcWithPkgs ]; 
  shellHook = ''
    zsh
  '';
}