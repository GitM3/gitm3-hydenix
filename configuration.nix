{
  inputs,
  ...
}:
let
  # Package declaration
  # ---------------------

  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      # permittedInsecurePackages = [
      #   ""
      # ];
    };
    overlays = [
      inputs.hydenix.overlays.default
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
          config = {
            allowUnfree = true;
          };
        };
      })
      (final: prev: {
        python3Packages = prev.python3Packages.overrideScope (
          pyFinal: pyPrev: {
            i3ipc = pyPrev.i3ipc.overridePythonAttrs (old: {
              doCheck = false;
            });
          }
        );
      })
      (final: prev: {
        khanelivim = inputs.khanelivim.overrideAttrs (old: {
          doCheck = false;
          doInstallCheck = false;
          dontCheck = true;
          checkPhase = "echo 'Skipping khanelivim tests'";
        });
      })
    ];
  };
in
{

  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.hydenix.nixosModules.default
    ./hardware-configuration.nix
    ./modules/system
    # === GPU-specific configurations ===

    /*
      For drivers, we are leveraging nixos-hardware
      Most common drivers are below, but you can see more options here: https://github.com/NixOS/nixos-hardware
    */

    # inputs.nixos-hardware.nixosModules.common-cpu-amd # AMD CPUs
    inputs.nixos-hardware.nixosModules.common-cpu-intel # Intel CPUs

    # Additional Hardware Modules - Uncomment based on your system type:
    # inputs.nixos-hardware.nixosModules.common-hidpi # High-DPI displays
    inputs.nixos-hardware.nixosModules.common-pc-laptop # Laptops
    inputs.nixos-hardware.nixosModules.common-pc-ssd # SSD storage

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
          inputs.hydenix.homeModules.default
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

    audio.enable = true; # enable audio module TODO: re-enable
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
    sddm = {
      enable = false; # enable sddm module
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
      "docker"
    ];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [
    "root"
    "zander"
  ]; # Adding for cachix
  system.stateVersion = "25.05";
}
