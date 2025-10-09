{
  config,
  lib,
  pkgs,
  ...
}:

let
  sddmAstronautTheme = pkgs.stdenv.mkDerivation {
    pname = "sddm-astronaut-theme";
    version = "2025-10-09";
    src = pkgs.fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "c10bd950544036c7418e0f34cbf1b597dae2b72f"; # <-- replace with a real rev
      hash = "sha256-ITufiMTnSX9cg83mlmuufNXxG1dp9OKG90VBZdDeMxw="; # fill in, see notes below
    };

    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
      cp -r ./* $out/share/sddm/themes/sddm-astronaut-theme/
    '';
    # pure data; no Qt deps
    dontFixup = true;

    meta = with lib; {
      homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
      description = "Astronaut SDDM theme (data-only packaging)";
      license = licenses.gpl3Plus;
      platforms = platforms.linux;
    };
  };
in
{
  # optional cursor env
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # system packages that don't affect SDDM’s Qt closure
  environment.systemPackages = [
    pkgs.Bibata-Modern-Ice
  ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm; # Qt6 in modern nixpkgs
    wayland.enable = true;

    # Tell SDDM which theme name to load (directory name we installed)
    theme = "sddm-astronaut-theme";

    # Ensure the theme is available in the system profile for SDDM
    extraPackages = [
      sddmAstronautTheme
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtvirtualkeyboard
    ];

    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = "24";
      };
      General.DefaultSession = "hyprland.desktop";
      Wayland.EnableHiDPI = true;
    };
  };
}
