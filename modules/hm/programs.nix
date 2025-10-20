{ pkgs, lib, ... }:
let
  py313 = pkgs.python313.withPackages (
    ps: with ps; [
      evdev
      pip
      pipx
      evdev
      setuptools
      wheel
      pyqt6
    ]
  );
in

{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set sandbox none
      set selection-clipboard "clipboard"
      set recolor-keephue true
    '';
  };
  home.sessionVariables = {
    PIPX_DEFAULT_PYTHON = "python312";
    # C_INCLUDE_PATH = "${pkgs.linuxHeaders}/include"; # This is for pipx
  };

  home.packages = with pkgs; [
    (lib.lowPrio py313)
    steam-unwrapped

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
    youtube-tui
    yt-dlp
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
    voicevox
    voicevox-core
    voicevox-engine

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
    gcc
    ueberzugpp

    qt6.qtwayland
    xorg.libxcb
    zstd
    zlib
    glib
    dbus
    freetype
    fontconfig
    icu
    xorg.libxcb
    libxkbcommon
    libGL
    stdenv.cc.cc
    stdenv.cc.cc.lib
    glib
    libxkbcommon
    libGL
    linuxHeaders
    libevdev
    nss
    nspr
    (pkgs.writeShellScriptBin "latexocr-run" ''
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:\
      ${pkgs.zstd}/lib:\
      ${pkgs.zlib}/lib:\
      ${pkgs.glib}/lib:\
      ${pkgs.dbus}/lib:\
      ${pkgs.freetype}/lib:\
      ${pkgs.nss}/lib:\
      ${pkgs.nspr}/lib:\
      ${pkgs.fontconfig}/lib:\
      ${pkgs.icu}/lib:\
      ${pkgs.xorg.libxcb}/lib:\
      ${pkgs.libxkbcommon}/lib:\
      ${pkgs.libGL}/lib:\
      ${pkgs.qt6.qtbase}/lib:\
      ${pkgs.qt6.qtwayland}/lib:''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
            : ''${QT_QPA_PLATFORM:=wayland}   # set to xcb to force X11
            exec "$HOME/.local/bin/latexocr" "$@"
    '')
  ];

}
