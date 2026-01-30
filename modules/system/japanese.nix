{
  pkgs,
  environment,
  ...
}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc # Japanese input method
      fcitx5-gtk # GTK integration
      qt6Packages.fcitx5-configtool # Configuration GUI
      fcitx5-nord # a color theme
    ];
    fcitx5.waylandFrontend = true;
  };

  environment.systemPackages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
  };
}
