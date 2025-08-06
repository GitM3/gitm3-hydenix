{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Disable the Hyde SDDM module since we're replacing it
  hydenix.sddm.enable = lib.mkForce false;

  environment.systemPackages = [
    pkgs.Bibata-Modern-Ice
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.libsForQt5.sddm;
    theme =
      let
        customTheme = pkgs.runCommand "sddm-corners-custom" { } ''
          mkdir -p $out/share/sddm/themes/Corners
          cp -r ${pkgs.hydenix.hyde}/share/sddm/themes/Corners/* $out/share/sddm/themes/Corners/
          cp ${../../resources/wallpapers/cat.png} $out/share/sddm/themes/Corners/backgrounds/bg.png
        '';
      in
      "${customTheme}/share/sddm/themes/Corners";

    wayland = {
      enable = true;
    };

    extraPackages = with pkgs; [
      libsForQt5.sddm
      libsForQt5.sddm-kcm
      libsForQt5.qtsvg
      libsForQt5.qtmultimedia
      libsForQt5.qtvirtualkeyboard
      libsForQt5.qtquickcontrols2
      libsForQt5.qtgraphicaleffects
      libsForQt5.layer-shell-qt
      libsForQt5.qt5.qtwayland
      hydenix.hyde
      Bibata-Modern-Ice
    ];

    settings = {
      Theme = {
        ThemeDir = "/run/current-system/sw/share/sddm/themes";
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = "24";
      };
      General = {
        DefaultSession = "hyprland.desktop";
      };
      Wayland = {
        EnableHiDPI = true;
      };
    };
  };
}
