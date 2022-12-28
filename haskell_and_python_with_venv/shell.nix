{ stdenv ? import <nixpkgs> {} }:

let
  inherit (stdenv) pkgs mkShell;
  inherit (stdenv.lib) flatten;

in

mkShell rec {
  name = "nix-shell";
  buildInputs =
    with pkgs; 
    with python310Packages; [
      python
      pip
      virtualenv
      wheel
      numpy
      pandas
      theano
      matplotlib
      statsmodels
      scipy
      mypy
    ];
    ghcWithPkgs = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
      turtle
      regex-tdfa
    ]);
    # vscode = with pkgs; [vscode-with-extensions];
    # vscodeExtentions = with pkgs.vscode-extensions; [
    #   ms-python.python
    #   ms-pyright.pyright
    #   ms-python.vscode-pylance
    #   vscodevim.vim
    #   haskell.haskell
    # ];

  shellHook = /* sh */ ''
    # virtualenv --no-setuptools .venv
    # source ./.venv/bin/activate
    ### unset PYTHONPATH  
    # pip install wheel numpy pandas theano matplotlib statsmodels scipy
  '';
}