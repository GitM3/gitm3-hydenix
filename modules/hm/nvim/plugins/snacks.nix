{
  plugins = {
    lualine.enable = true;
    web-devicons.enable = true;
    telescope = {
      enable = true;

      settings.defaults = {
        layout_strategy = "horizontal";
        layout_config.prompt_position = "top";
        sorting_strategy = "ascending";
      };
    };
  };
}
