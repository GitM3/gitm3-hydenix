{
  pkgs,
  lib,
  ...
}: let
  my_tex = pkgs.texlive.combined.scheme-full.withPackages (
    ps:
      with ps; [
        platex
        uplatex
        ptex
        ptex-base
        ptex-fonts
        bxwareki
        japanese-otf
        jsclasses
        haranoaji
        ipaex
      ]
  );
in {
  options.my.texlivePackage = lib.mkOption {
    type = lib.types.package;
    readOnly = true;
    default = my_tex;
    description = "Japanese TeX Live distribution";
  };
  config.home.packages = [my_tex];
}
