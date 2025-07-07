{ pkgs, ... }:

{
  # Install packages
  home.packages = with pkgs; [
    syncthing
    rclone
    restic
  ];
  # Syncthing service (user-level)
  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
      command = "syncthingtray --wait";
    };
  };

}
