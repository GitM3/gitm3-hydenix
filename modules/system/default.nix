{ inputs, pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
    ntfs3g
    exfat
    fuse
    fuse3

    # Development
    devenv
    cachix
  ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GOLDENDICT_FORCE_WAYLAND = 1;
  };
}
