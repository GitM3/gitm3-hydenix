{
  imports = [
    ./python.nix
    ./latex.nix
  ];

  programs.nixvim.plugins.lsp = {
    enable = true;
  };
}
