{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.file.".markdownlint.jsonc" = lib.mkForce {
    text = ''
        {
        "default": true,
        "MD013": false, // Disable line length rule
        "MD025": false
      }
    '';
    force = true;
    mutable = true;
  };

  home.packages = [
    (
      let
        baseConfig = inputs.my_nvim.nixvimConfigurations.x86_64-linux.khanelivim;

        # extendModules is still fine for extraConfigLua
        extendedConfig = baseConfig.extendModules {
          modules = [
            {
              config = {
                extraConfigLua = ''
                  -- Window navigation with Ctrl+hjkl
                  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
                  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to bottom window' })
                  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to top window' })
                  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
                '';
              };
            }
          ];
        };

        # Patch the *final package* to skip tests
        patchedPackage = extendedConfig.config.build.package.overrideAttrs (old: {
          doInstallCheck = false;
          dontCheck = true;
          doCheck = false;
          checkPhase = "echo 'Skipping khanelivim tests'";
        });
      in
      patchedPackage
    )
    pkgs.vim
  ];
}
