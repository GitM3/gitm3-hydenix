{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    anki-bin 
    obsidian
    bat
    zellij
    lazygit
    lazydocker
    git-graph
    zathura
    adobe-reader
  ];
}

