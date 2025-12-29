{config, ...}: {
  plugins.vimtex = {
    enable = true;
    settings = {
      view_method = "zathura";
      compiler_method = "latexmk";
    };
  };
}
