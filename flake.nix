{
  description = "template for hydenix";

  inputs = {
    # User's nixpkgs - for user packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    # Hydenix and its nixpkgs - kept separate to avoid conflicts
    hydenix = {
      # Available inputs:
      # Main: github:richen604/hydenix
      # Dev: github:richen604/hydenix/dev
      # Commit: github:richen604/hydenix/<commit-hash>
      # Version: github:richen604/hydenix/v1.0.0
      url = "github:richen604/hydenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";
    my_nvim = {
      url = "path:/home/zander/Development/khanelivim";
    };
    # khanelivim = {
    #   url = "github:khaneliman/khanelivim/1995815bfad345a13befcfdcaa8d1a5c34588d0d";
    # };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    let
      HOSTNAME = "zander";

      system = "x86_64-linux";
      hydenixConfig = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/system/japanese.nix
          ./configuration.nix
        ];
      };

    in
    {
      nixosConfigurations.nixos = hydenixConfig;
      nixosConfigurations.${HOSTNAME} = hydenixConfig;
    };
}
