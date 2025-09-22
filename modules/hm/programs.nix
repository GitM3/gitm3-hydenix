{ pkgs, ... }:
{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set sandbox none
    '';
  };
  home.packages = with pkgs; [

    # Shell
    bat
    zoxide
    lazygit
    lazydocker
    git-graph
    navi
    fzf
    pay-respects
    fastfetch
    nodejs_20
    htop
    # Zsh
    zsh-you-should-use
    pywal
    pywalfox-native
    spicetify-cli

    # Development
    # kicad
    docker-compose

    # utils / tools
    qbittorrent
    anki-bin # Addons: 1344485230  2055492159  312734862
    goldendict-ng
    obsidian
    google-chrome
    vlc
    xournalpp
    unzip
    atool
    calibre
    scrcpy
    dupeguru
    parted
    rsync
    nwg-displays
    (clementine.override {
      config = {
        clementine.ipod = true;
      };
    })
    libreoffice-fresh
    # Productivity
    stretchly
    slack

    # deps
    mpv
    poppler
    jq
    ripgrep
    imagemagick
    fd
    zip
    unzip
    tree
  ];

}
