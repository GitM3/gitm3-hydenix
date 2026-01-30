{hmConfig, ...}: {
  plugins.vimtex = {
    enable = true;
    texlivePackage = hmConfig.my.texlivePackage;
    settings = {
      view_method = "zathura";
      compiler_method = "latexmk";
    };
  };
}
