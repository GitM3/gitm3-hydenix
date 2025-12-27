{ inputs, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    imports = [
      ./options.nix
      ./keymaps.nix
      ./plugins
      ./lsp
      ./themes/tokyonight.nix 
    ];
  };
}
