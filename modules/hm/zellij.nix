{ lib, ... }:
{
  home.file.".config/zellij/config.kdl" = lib.mkForce {
    text = ''
      keybinds {
          normal {
              bind "Ctrl u" { SwitchToMode "Move"; }
              unbind "Ctrl h"
          }
      }
      theme "catppuccin-mocha"
    '';
  };
  # theme "iceberg-dark" is also nice, more "blue/nordy"
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    attachExistingSession = true;
  };
}
