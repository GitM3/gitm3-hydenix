{ pkgs, ... }:
{
  home.packages = with pkgs; [

    # Shell
    bat
    zellij
    zoxide
    lazygit
    lazydocker
    git-graph
    navi

    # utils / tools
    zathura
    adobe-reader
    qbittorrent
    anki-bin # Addons: 1344485230  2055492159  312734862
    goldendict-ng
    obsidian
    google-chrome
    vlc
    xournalpp
    bottles

    # deps
    mpv
  ];
}
