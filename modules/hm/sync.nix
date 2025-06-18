{ pkgs, ... }:

{
  # Install packages
  home.packages = with pkgs; [
    syncthing
    rclone
  ];

  # Syncthing service (user-level)
  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
      command = "syncthingtray --wait";
    };
  };

  # Create systemd user service for Google Drive sync
  systemd.user.services.obsidian-gdrive-sync = {
    Unit = {
      Description = "Sync Obsidian vault to Google Drive";
      After = [ "network-online.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.rclone}/bin/rclone sync %h/Documents/Obsidian gdrive:Obsidian --exclude '*.tmp' --exclude '.stfolder' --exclude '.stignore'";
    };
  };

  # Timer for regular sync
  systemd.user.timers.obsidian-gdrive-sync = {
    Unit = {
      Description = "Timer for Obsidian Google Drive sync";
    };

    Timer = {
      OnBootSec = "5min";
      OnUnitActiveSec = "10min";
      Persistent = true;
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # Create rclone config directory
  home.file.".config/rclone/.keep".text = "";

  # Script for easy manual sync
  home.file.".local/bin/sync-obsidian" = {
    text = ''
      #!/bin/sh
      ${pkgs.rclone}/bin/rclone sync "$HOME/Documents/Obsidian" gdrive:Obsidian --exclude '*.tmp' --exclude '.stfolder' --exclude '.stignore'
      echo "Obsidian vault synced to Google Drive"
    '';
    executable = true;
  };
}
