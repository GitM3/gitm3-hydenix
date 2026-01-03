{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./snacks.nix
    ./treesitter.nix
    ./undo.nix
    ./ui.nix
    ./harpoon.nix
    ./yazi.nix
    ./latex.nix
    ./snippets.nix
  ];
  plugins.lz-n = {
    enable = true;
    autoLoad = true;
  };
}
