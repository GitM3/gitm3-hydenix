{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    version.enableNixpkgsReleaseCheck = false;
    extraPackages = [
      pkgs.texlab
    ];
    imports = [
      ./options.nix
      ./keymaps.nix
      ./plugins
      ./lsp
      ./themes/cat.nix
    ];
  };
}
