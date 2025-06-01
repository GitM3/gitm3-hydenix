{ ... }:

{
  imports = [
    # ./example.nix - add your modules here
  ];

  environment.systemPackages = [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];
environment.variables = {
  GDK_SCALE = "0.8";           # Make GTK apps smaller
  QT_SCALE_FACTOR = "0.8";     # Make Qt apps smaller
  XCURSOR_SIZE = "24";         # Reasonable cursor size
  GDK_DPI_SCALE = "0.8";       # GTK DPI scaling
};
}
