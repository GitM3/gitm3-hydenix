{ pkgs, ... }:
{
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
    # Zsh
    zsh-you-should-use
    pywal
    pywalfox-native
    spicetify-cli

    # Development
    # kicad

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
