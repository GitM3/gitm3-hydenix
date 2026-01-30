{hmConfig, ...}: {
  plugins = {
    vimtex = {
      enable = true;
      texlivePackage = hmConfig.my.texlivePackage;
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
