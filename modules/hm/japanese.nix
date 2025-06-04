 { pkgs,environment, ... }:

{

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc        # Japanese input method
      fcitx5-gtk         # GTK integration
      fcitx5-configtool  # Configuration GUI
      fcitx5-nord            # a color theme
    ];
    fcitx5.waylandFrontend = true;
  };
}
