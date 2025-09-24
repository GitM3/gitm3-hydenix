{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Override the userprefs.conf that Hydenix manages with fcitx5 configuration
  home.file.".config/hypr/userprefs.conf" = lib.mkForce {
    text = ''
      ## █░█ █▀ █▀▀ █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀
      ## █▄█ ▄█ ██▄ █▀▄ █▀▀ █▀▄ ██▄ █▀░ ▄█
      # User Preferences Configuration

      # Environment variables for fcitx5 input method
      env = QT_IM_MODULE,fcitx
      env = XMODIFIERS,@im=fcitx
      env = SDL_IM_MODULE,fcitx
      env = GLFW_IM_MODULE,ibus
      env = INPUT_METHOD,fcitx
      input {
        kb_options = caps:escape_shifted_capslock, compose:rctrl
      }
      # Start fcitx5 daemon on Hyprland startup
      exec-once = fcitx5 -d
      exec-once = gammastep-indicator &
      exec-once = stretchly &
      exec-once = qnotero &
    '';
  };
}
