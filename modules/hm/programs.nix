{ pkgs, ... }:
{
  programs.flatpak = {
    enable = true;

    remotes.flathub = {
      url = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      extraOptions = "--if-not-exists";
    };

    packages = [ "com.usebottles.bottles" ];
  };
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
    qbittorrent
    anki-bin # Addons: 1344485230  2055492159  312734862
    goldendict-ng
    obsidian
    google-chrome
    vlc
    xournalpp
    unzip
    atool

    # deps
    mpv
  ];
}
