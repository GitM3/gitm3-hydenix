{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Window left";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Window right";
    }
    {
      mode = "n";
      key = "<leader>y";
      action = ":Yazi<CR>";
      options.desc = "Open Yazi";
    }
  ];
}
