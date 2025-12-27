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
    };
    flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";
    # my_nvim = {
    #   url = "path:/home/zander/Development/khanelivim";
    # };
    # khanelivim = {
    #   url = "github:khaneliman/khanelivim/1995815bfad345a13befcfdcaa8d1a5c34588d0d";
    # };
    # Nix-index-database - for comma and command-not-found
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    let
      HOSTNAME = "zander";

      hydenixConfig = inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
        inherit (inputs.hydenix.lib) system;
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
