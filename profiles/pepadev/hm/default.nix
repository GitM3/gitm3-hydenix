{ pkgs, nixvim, ... }:

{
  imports = [
    nixvim.homeModules.nixvim
    ../../../modules/hm/nvim
  ];

  home.username = "pepadev";
  home.homeDirectory = "/home/pepadev";
  home.stateVersion = "25.11";
}

