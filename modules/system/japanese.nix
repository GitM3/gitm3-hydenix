 { lib, pkgs, config, ... }: {
  options.mine.japaneseInput = lib.mkEnableOption "japanese input";

  config = lib.mkIf config.mine.japaneseInput {

    # Only really for env vars
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = [
        pkgs.fcitx5-mozc
        pkgs.fcitx5-nord
        pkgs.fcitx5-configtool
      ];
    };

    # Would normally set this to fcitx, but kitty only supports ibus, and fcitx
    # provides an ibus interface. Can't use ibus for e.g. QT_IM_MODULE though,
    # because that at least breaks mumble
    environment.variables.GLFW_IM_MODULE = "ibus";

    # mine.xUserConfig.xsession.initExtra = ''
    #   ${config.i18n.inputMethod.package}/bin/fcitx5 &
    # '';
    systemd.user.services.fcitx5-daemon = {
    enable = true;
    description = "Fcitx5 input method editor";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
      Restart = "on-failure";
    };

  };
 };
}
# { pkgs,environment, ... }:
#
#{
#
#  i18n.inputMethod = {
#    type = "fcitx5";
#    enable = true;
#    fcitx5.addons = with pkgs; [
#      fcitx5-mozc        # Japanese input method
#      fcitx5-gtk         # GTK integration
#      fcitx5-configtool  # Configuration GUI
#      fcitx5-nord            # a color theme
#    ];
#  };
#
#  environment.systemPackages = with pkgs; [
#    fcitx5
#    fcitx5-mozc
#    fcitx5-configtool
#    fcitx5-gtk
#    
#    noto-fonts-cjk-sans
#    noto-fonts-cjk-serif
#  ];
#  environment.variables = {
#  GTK_IM_MODULE = "fcitx";
#  QT_IM_MODULE = "fcitx";
#  XMODIFIERS = "@im=fcitx";
#  GLFW_IM_MODULE = "ibus";
#};
#
#  fonts = {
#    packages = with pkgs; [
#      noto-fonts-cjk-sans
#      noto-fonts-cjk-serif
#      noto-fonts-emoji
#    ];
#  };
#}
