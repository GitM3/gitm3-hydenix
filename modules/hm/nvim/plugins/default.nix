{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./snacks.nix
    ./treesitter.nix
    ./undo.nix
    ./ui.nix
    ./harpoon.nix
    ./image.nix
    ./yazi.nix
    ./latex.nix
    ./obsidian.nix
    ./snippets.nix
  ];
  plugins.lz-n = {
    enable = true;
    autoLoad = true;
  };
}
