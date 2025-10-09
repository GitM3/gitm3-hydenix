{
  description = "LaTeX OCR (pix2tex) packaged for Nix with Qt6 WebEngine support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        py = pkgs.python312; # stick to 3.12 for stability
        pyPkgs = pkgs.python312Packages; # match python version above
        simsimd = pyPkgs.buildPythonPackage rec {
          pname = "simsimd";
          version = "5.9.1"; # pick a version compatible with albucore 0.0.23 (>=3,<6 typically works)
          src = pkgs.fetchPypi {
            inherit pname version;
            # Nix will print the wanted sha256 once; paste it back here:
            sha256 = "sha256-9Fk/eU2EpmMokNP6qjsQWaoXbMLn3djLf6zs7uMvZIE= ";
            # Force wheel to avoid sdist builds:
            # (If your nixpkgs fetchPypi can’t force wheel, use fetchurl with the .whl URL)
          };
          format = "wheel";
          nativeBuildInputs = [
            pyPkgs.setuptools
            pyPkgs.wheel
          ];
          propagatedBuildInputs = [ ]; # none
          doCheck = false;
        };
        albucore_23 = pyPkgs.buildPythonPackage rec {
          pname = "albucore";
          version = "0.0.23";
          src = pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-V4I5grlUkTuEqeLPcQWMRXewI5emLEGIW+LZspXvqKs="; # build once; paste real hash
          };
          format = "pyproject";
          nativeBuildInputs = with pyPkgs; [
            setuptools
            wheel
            opencv-python-headless
            stringzilla
            simsimd
          ];
          propagatedBuildInputs = with pyPkgs; [
            numpy
            typing-extensions
            simsimd
          ];
          doCheck = false;
        };

        albumentations_1 = pyPkgs.buildPythonPackage rec {
          pname = "albumentations";
          version = "1.4.24";
          src = pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-zIh0ywq8zJEXrvrL44XDVKyCT6FC9GpsCJbWXOxfim0=";
          };
          format = "pyproject";
          propagatedBuildInputs = with pyPkgs; [
            numpy
            setuptools
            pydantic
            albucore_23
            opencv-python-headless
            scikit-image
            qudida
            pyyaml
            typing-extensions
          ];
          doCheck = false;
        };
      in
      {
        packages.latexocr = pyPkgs.buildPythonApplication rec {
          pname = "pix2tex";
          version = "0.1.3.2";

          src = pkgs.fetchurl {
            url = "https://files.pythonhosted.org/packages/c4/ce/153c029c5eb02cd440a6615428680963a8a4932e4a52f79d91a5daa54bd4/pix2tex-0.1.3-py3-none-any.whl";
            sha256 = "sha256-RLGFZnYGwh6e3sefJv3R6IrdP9D/oUXMWI4pcyoaHSY="; # build to get real hash
          };

          format = "wheel";
          propagatedBuildInputs = with pyPkgs; [
            pyqt6
            pyqt6-webengine
            pillow
            numpy
            requests
            tqdm
            opencv-python-headless
            pynput
            screeninfo
            albumentations_1
            torch-bin
          ];
          nativeBuildInputs = with pkgs; [
            qt6.wrapQtAppsHook
          ];
          buildInputs = with pkgs; [
            qt6.qtbase
            qt6.qtdeclarative
            qt6.qtwebengine
            qt6.qtwayland
            libglvnd
            libGL
            libxkbcommon
            xorg.libxcb
            nss
            nspr
            zstd
            zlib
            icu
            stdenv.cc.cc.lib

          ];
          doCheck = false;
        };
        packages.default = self.packages.${system}.latexocr;
      }
    );
}
