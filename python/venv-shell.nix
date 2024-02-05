# example from nixpkgs manual:
# https://nixos.org/manual/nixpkgs/stable/#how-to-consume-python-modules-using-pip-in-a-virtual-environment-like-i-am-used-to-on-other-operating-systems
with import <nixpkgs> {}; let
  venvDir = "./.venv";
  pythonPackages = python3Packages;
in
  pkgs.mkShell rec {
    name = "impurePythonEnv";
    buildInputs = [
      pythonPackages.python
      # Needed when using python 2.7
      # pythonPackages.virtualenv
      # ...
    ];

    # This is very close to how venvShellHook is implemented, but
    # adapted to use 'virtualenv'
    shellHook = ''
      SOURCE_DATE_EPOCH=$(date +%s)

      if [ -d "${venvDir}" ]; then
        echo "Skipping venv creation, '${venvDir}' already exists"
      else
        echo "Creating new venv environment in path: '${venvDir}'"
        # Note that the module venv was only introduced in python 3, so for 2.7
        # this needs to be replaced with a call to virtualenv
        ${pythonPackages.python.interpreter} -m venv "${venvDir}"
      fi

      # Under some circumstances it might be necessary to add your virtual
      # environment to PYTHONPATH, which you can do here too;
      # PYTHONPATH=$PWD/${venvDir}/${pythonPackages.python.sitePackages}/:$PYTHONPATH

      source "${venvDir}/bin/activate"

      # As in the previous example, this is optional.
      pip install -r requirements.txt
    '';
  }
