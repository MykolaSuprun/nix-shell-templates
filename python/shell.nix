{ pkgs ? import <nixpkgs> {} }:
let
  pipPkgs = pkgs.lib.strings.concatStringsSep " " [
    "argparse"
    "blue"
    "wheel"
    "numpy"
  ];
in
pkgs.mkShell {
  name = "venv";
  buildInputs = with pkgs.python311Packages; [
    python
    pip
    virtualenv
  ];
  shellHooks =  ''
    virtualenv --no-setuptools .venv
    source ./.venv/bin/activate
    pip install ${pipPkgs}
    zsh
  '';
}
