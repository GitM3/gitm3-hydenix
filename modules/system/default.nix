{ inputs, pkgs, ... }:

{
  imports = [
#    ./japanese.nix
  ];

  environment.systemPackages = with pkgs; [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
    ntfs3g
    exfat
    fuse
    fuse3
  ];
environment.variables = {
};
}
