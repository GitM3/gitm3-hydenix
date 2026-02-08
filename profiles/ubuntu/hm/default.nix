{ pkgs,config, nixvim, ... }:

{
  imports = [
    ../../../modules/hm/tex.nix
    nixvim.homeModules.nixvim
    ../../../modules/hm/nvim
  ];

  programs.nixvim.extraSpecialArgs = {
    texlivePackage = config.my.texlivePackage;
  };
  home.username = "pepadev";
  home.homeDirectory = "/home/pepadev";
  home.stateVersion = "25.11";
}

