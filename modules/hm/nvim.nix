{ pkgs, inputs, ... }:
{
  home.packages = [
    (
      let
        baseConfig = inputs.khanelivim.nixvimConfigurations.x86_64-linux.khanelivim;
        extendedConfig = baseConfig.extendModules {
          modules = [
            {
              extraConfigLua = ''
                -- Window navigation with Ctrl+hjkl
                vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
                vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to bottom window' })
                vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to top window' })
                vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
              '';
            }
          ];
        };
      in
      extendedConfig.config.build.package
    )
    pkgs.vim
  ];
}
