{
  programs.nixvim.opts = {
    number = true;
    relativenumber = true;

    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;

    undofile = true;
    undodir = "~/.local/state/nvim/undo";

    termguicolors = true;
    signcolumn = "yes";
    updatetime = 250;
  };
}
