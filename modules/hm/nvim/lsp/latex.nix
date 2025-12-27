{
  programs.nixvim.plugins.lsp.servers.texlab = {
    enable = true;
    settings = {
      texlab.build.executable = "latexmk";
    };
  };
}
