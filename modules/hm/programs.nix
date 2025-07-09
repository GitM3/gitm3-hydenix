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
    fzf

    # Zsh
    zsh-you-should-use

    # utils / tools
    zathura
    qbittorrent
    anki-bin # Addons: 1344485230  2055492159  312734862
    goldendict-ng
    obsidian
    google-chrome
    vlc
    xournalpp
    unzip
    atool

    # Productivity
    stretchly
    activitywatch
    awatcher


    # deps
    mpv
  ];
}
