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
      theme "iceberg-dark"
    '';
  };
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    attachExistingSession = true;
  };
}
