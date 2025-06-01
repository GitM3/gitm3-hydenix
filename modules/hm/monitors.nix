{ config, lib, pkgs, ... }:

{
  # Override the monitors.conf file that Hydenix manages
  home.file.".config/hypr/monitors.conf" = lib.mkForce {
    text = ''
      monitor = eDP-1,1920x1080@60,0x0,1.2
      
      # Add any other monitor configurations here
      # monitor = HDMI-A-1,1920x1080@60,1920x0,1.0
    '';
  };
}
