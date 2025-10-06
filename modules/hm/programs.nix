{ pkgs, lib, ... }:
let
  py312-bin-only = pkgs.symlinkJoin {
    name = "python312-bin-only";
    paths = [ pkgs.python312 ];
    pathsToLink = [ "/bin" ]; # avoids /share/man collisions
  };
in
{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set sandbox none
      set selection-clipboard "clipboard"
    '';
  };
  home.sessionVariables.PIPX_DEFAULT_PYTHON = "${pkgs.python312}/bin/python3.12";
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
    pipx
    py312-bin-only

    # Development
    # kicad
    f3d
    meshlab

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

    # Productivity
    stretchly
    slack
    zotero
    qnotero
    wlvncc

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
