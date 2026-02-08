{hmConfig, pkgs, ...}: 

let
  fallbackTex =
    pkgs.texlive.combined.scheme-full.withPackages (ps: with ps; [
      platex uplatex ptex ptex-base ptex-fonts
      bxwareki japanese-otf jsclasses haranoaji ipaex
    ]);

  texPkg =
    if hmConfig != null
       && (hmConfig ? my)
       && (hmConfig.my ? texlivePackage)
    then hmConfig.my.texlivePackage
    else fallbackTex;

in

{
  plugins = {
    vimtex = {
      enable = true;
      texlivePackage = texPkg;
      settings = {
        compiler_silent = true;
        compiler_callback = 0;

        view_method = "zathura";
        view_use_temp_files = true;
        view_general_options = "-reuse-instance";
        compiler_method = "latexmk";
      };
    };
    ltex-extra.enable = true;
  };
}
