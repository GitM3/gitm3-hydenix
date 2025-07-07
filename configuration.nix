{
  inputs,
  ...
}:
let
  # Package declaration
  # ---------------------

  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
	  config = {
	    allowUnfree = true;
	    # permittedInsecurePackages = [
	    #   ""
	    # ];
	  };
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
        config = {
            allowUnfree = true;
         };
        };
      })
    ];
  };
in
{

  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;
  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    inputs.hydenix.lib.nixOsModules
    ./modules/system
    # === GPU-specific configurations ===

    /*
      For drivers, we are leveraging nixos-hardware
      Most common drivers are below, but you can see more options here: https://github.com/NixOS/nixos-hardware
    */

    #! EDIT THIS SECTION
    # For NVIDIA setups
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    # For AMD setups
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd

    # === CPU-specific configurations ===
    # For AMD CPUs
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd

    # For Intel CPUs
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-intel

    # === Other common modules ===
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
    users."zander" =
      { ... }:
      {
        imports = [
          inputs.hydenix.lib.homeModules
          # Nix-index-database - for comma and command-not-found
          inputs.nix-index-database.hmModules.nix-index
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
    timezone = "Africa/Johannesburg"; # Change to your timezone
    locale = "en_ZA.UTF-8"; # Change to your preferred locale


      audio.enable = true; # enable audio module
      boot = {
        enable = true; # enable boot module
        useSystemdBoot = false; # disable for GRUB
        grubTheme = "Pochita"; # or pkgs.hydenix.grub-pochita
        grubExtraConfig = ""; # additional GRUB configuration
        kernelPackages = pkgs.linuxPackages_zen; # default zen kernel
      };
      hardware.enable = true; # enable hardware module
      network.enable = true; # enable network module
      nix.enable = true; # enable nix module
      sddm = {
        enable = true; # enable sddm module
        theme = "Corners";
      };
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
    ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.05";
}
