{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./sddm.nix
  ];

  networking = {

    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    firewall.allowedUDPPorts = [
      67
      68
      3478
      41641
    ];
    firewall.allowedTCPPorts = [
      22
      80
      443
      8080
    ];
  };
  security.pam.services.sddm.enableGnomeKeyring = true;
  services = {
    tailscale.enable = true;
    udev.packages = [ pkgs.librealsense ];
    gnome.gnome-keyring.enable = true;
    printing = {
      enable = true;
      browsed.enable = false;
    };
    avahi = {
      enable = true;
      openFirewall = true;
    };
    flatpak.enable = true;
    tlp = {
      enable = true;
      settings = {
        # Make TLP stick to the last detected power source across reboots (nice on desktops too)
        TLP_PERSISTENT_DEFAULT = "1";

        # CPU governor & EPP (works on Intel P-state/AMD P-state systems)
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Kernel scheduler
        SCHED_POWERSAVE_ON_AC = "0";
        SCHED_POWERSAVE_ON_BAT = "1";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
    ntfs3g
    exfat
    fuse
    fuse3
    opentabletdriver
    podman-compose

    # Development
    distrobox
    devenv
    cachix
    librealsense-gui
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GOLDENDICT_FORCE_WAYLAND = 1;
  };
  hardware.enableRedistributableFirmware = true;
  # virtualisation.docker = {
  #   enable = true;
  # };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

}
