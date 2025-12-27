{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./audio.nix
  ];

  networking = {

    #useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    networkmanager.wifi.macAddress = "preserve";
    #interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    firewall.enable = lib.mkForce false;
    firewall.allowedUDPPorts = [
      67
      68
      3478
      41641
      # ROS
      7400
      7401
      7410
      7411
      38150
      38151
      38406
      38407
    ];
    firewall.allowedTCPPorts = [
      22
      80
      443
      8080
    ];
    nat = {
      enable = true;
      externalInterface = "wlp0s20f3";
      internalInterfaces = [ "enp0s31f6" ];
    };
  };
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  security = {
    pam.services.sddm.enableGnomeKeyring = true;
    rtkit.enable = true;
  };
  users.groups.plugdev = { };

  services = {
    tailscale.enable = true;
    udev.packages = [
      (pkgs.writeTextFile {
        name = "realsense-udev-rules";
        destination = "/etc/udev/rules.d/99-realsense-libusb.rules";
        text = builtins.readFile ./dev_rules/99-realsense-libusb.rules;
      })
    ];
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
    curl
    zenity

    # Development
    distrobox
    devenv
    cachix
    librealsense-gui
    librealsense
    # nix-ld

    #wine stuff
    wineWowPackages.stable
    wine
    (wine.override { wineBuild = "wine64"; })
    wine64
    winetricks
    wineWowPackages.waylandFull
    wineasio

  ];
  # programs.nix-ld.libraries = with pkgs; [
  #   stdenv.cc.cc.lib
  #   zstd
  #   zlib
  #   glib
  #   dbus
  #   nss
  #   nspr
  #   freetype
  #   fontconfig
  #   icu
  #   nss
  #   nspr
  #   xorg.libxcb
  #   xorg.libxkbfile
  #   libxkbcommon
  #   libGL
  #   qt6.qtbase
  #   qt6.qtwayland
  # ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GOLDENDICT_FORCE_WAYLAND = 1;
  };
  hardware.enableRedistributableFirmware = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  #   dockerSocket.enable = true;
  # };

}
