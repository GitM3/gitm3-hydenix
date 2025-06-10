{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # normal
    anki-bin # Addons: 1344485230  2055492159  312734862
    goldendict-ng
    obsidian

    # Shell
    bat
    zellij
    zoxide
    lazygit
    lazydocker
    git-graph

    # utils
    zathura
    adobe-reader

    # deps
    mpv
  ];
}

