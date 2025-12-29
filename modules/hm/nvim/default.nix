{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      config.my.texlivePackage
      pkgs.texlive.combined.scheme-full
      pkgs.texlab
    ];

    imports = [
      ./options.nix
      ./keymaps.nix
      ./plugins
      ./lsp
      ./themes/tokyonight.nix
    ];
  };
}
