{ stdenv ? import <nixpkgs> {} }:

let

  inherit (stdenv) pkgs mkShell;
  inherit (stdenv.lib) flatten;

in

mkShell rec {
  name = "venv";
  buildInputs =
    with pkgs;
    with python310Packages; [
      python
      pip
      virtualenv
    ];

  shellHook = /* sh */ ''
    virtualenv --no-setuptools .venv
    source ./.venv/bin/activate
    unset PYTHONPATH
    pip install wheel numpy pandas
  '';
}