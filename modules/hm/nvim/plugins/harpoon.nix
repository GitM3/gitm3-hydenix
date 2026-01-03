{
  config,
  lib,
  ...
}: {
  plugins = {
    harpoon = {
      enable = true;

      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>ha";
          __unkeyed-2.__raw = ''
            function()
              require'harpoon':list():add()
            end
          '';
          desc = "Add file";
        }
        {
          __unkeyed-1 = "<leader>he";
          __unkeyed-2.__raw = ''
            function()
              require'harpoon'.ui:toggle_quick_menu(require'harpoon':list())
            end
          '';
          desc = "Quick Menu";
        }
        {
          __unkeyed-1 = "<leader>1";
          __unkeyed-2.__raw = ''
            function()
              require'harpoon':list():select(1)
            end
          '';
          desc = "1";
        }
        {
          __unkeyed-1 = "<leader>2";
          __unkeyed-2.__raw = ''
            function()
              require'harpoon':list():select(2)
            end
          '';
          desc = "2";
        }
        {
          __unkeyed-1 = "<leader>3";
          __unkeyed-2.__raw = ''
            function()
              require'harpoon':list():select(3)
            end
          '';
          desc = "3";
        }
      ];
    };

    which-key.settings.spec = {
      __unkeyed-1 = "<leader>h";
      group = "Harpoon";
      icon = "󱡀 ";
    };
  };
}
