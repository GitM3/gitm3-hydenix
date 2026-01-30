{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    inputs.hydenix.nixosModules.default
    ./modules/system

    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    backupFileExtension = "hm_backup";
    users."zander" = {...}: {
      imports = [
        inputs.hydenix.homeModules.default
        # Nix-index-database - for comma and command-not-found
        inputs.nix-index-database.homeModules.nix-index
        inputs.flatpaks.homeManagerModules.nix-flatpak
        ./modules/hm/flatpak.nix
        ./modules/hm
      ];
    };
  };

  # IMPORTANT: Customize the following values to match your preferences
  hydenix = {
    enable = true; # Enable the Hydenix module

    #! EDIT THESE VALUES
    hostname = "zander"; # Change to your preferred hostname
    timezone = "Asia/Tokyo"; # Change to your timezone
    locale = "en_ZA.UTF-8"; # Change to your preferred locale

    audio.enable = false; # enable audio module
    boot = {
      enable = true; # enable boot module
      useSystemdBoot = true; # disable for GRUB
      grubTheme = "Pochita"; # or pkgs.hydenix.grub-pochita
      grubExtraConfig = ""; # additional GRUB configuration
      kernelPackages = pkgs.linuxPackages_zen; # default zen kernel
    };
    hardware.enable = true; # enable hardware module
    network.enable = true; # enable network module
    nix.enable = true; # enable nix module
    sddm.enable = true; # enable sddm module
    system.enable = true; # enable system module
  };

  #! EDIT THESE VALUES (must match users defined above)
  users.users.zander = {
    isNormalUser = true; # Regular user account
    initialPassword = "zander"; # Default password (CHANGE THIS after first login with passwd)
    extraGroups = [
      "wheel" # For sudo access
      "networkmanager" # For network management
      "video" # For display/graphics access
      "dialout"
      "sudo"
      "docker"
      "plugdev"
      "pipewire"
      "audio"
      "rtkit"
    ];
    shell = pkgs.zsh;
  };
  users.extraGroups.docker.members = ["zander"];
  nix.settings.trusted-users = [
    "root"
    "zander"
  ]; # Adding for cachix
  system.stateVersion = "25.05";
}
