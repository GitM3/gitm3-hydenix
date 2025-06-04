{ config, lib, pkgs, ... }:
{
  # Override the userprefs.conf that Hydenix manages with fcitx5 configuration
  home.file.".config/hypr/userprefs.conf" = lib.mkForce {
    text = ''
      ## █░█ █▀ █▀▀ █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀
      ## █▄█ ▄█ ██▄ █▀▄ █▀▀ █▀▄ ██▄ █▀░ ▄█
      # User Preferences Configuration
      
      # Environment variables for fcitx5 input method
      env = GTK_IM_MODULE,fcitx
      env = QT_IM_MODULE,fcitx  
      env = XMODIFIERS,@im=fcitx
      env = SDL_IM_MODULE,fcitx
      env = GLFW_IM_MODULE,ibus
      env = INPUT_METHOD,fcitx
      
      # Start fcitx5 daemon on Hyprland startup
      exec-once = fcitx5 -d
    '';
  };
}
