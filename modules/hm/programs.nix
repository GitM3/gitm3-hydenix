{ pkgs, ... }:
{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set sandbox none
      set selection-clipboard "clipboard"
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
    pandoc
    tailscale

    # Productivity
    stretchly
    slack
    zotero
    qnotero

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
    wget
  ];

}
