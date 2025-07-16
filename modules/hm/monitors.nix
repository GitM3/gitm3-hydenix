{ config, lib, pkgs, ... }:

{
  # Override the monitors.conf file that Hydenix manages
  home.file.".config/hypr/monitors.conf" = lib.mkForce {
    text = ''
      monitor = eDP-1,1920x1080@60,0x0,1.2
      monitor = HDMI-A-1,preffered,auto,1.2
      ## Side-by-side (external monitor to the right)
      # monitor = HDMI-A-1,1920x1080@60,1920x0,1.0  # External at (1920,0)

      ## Stacked (external monitor above laptop)
      # monitor = eDP-1,1920x1080@60,0x1080,1.2     # Laptop at bottom
      # monitor = HDMI-A-1,1920x1080@60,0x0,1.0     # External at top


      # Displayport monitors
      monitor = DP-1,preferred,auto,1.0
      monitor = DP-2,preferred,auto,1.0

      # USB-C/Thunderbolt monitors
      monitor = DP-3,preferred,auto,1.0
      monitor = DP-4,preferred,auto,1.0
    '';
  };
}
