{
  config,
  lib,
  ...
}: {
  plugins.obsidian = {
    enable = true;
    lazyLoad.settings = {
      cmd = [
        "Obsidian"
      ];
      ft = ["markdown"];
      event = [
        "BufReadPre"
        "BufNewFile"
      ];
    };
    settings = {
      legacy_commands = false;
      workspaces = [
        {
          name = "notes";
          path = "~/Documents/Obsidian/K4IZ3N/";
        }
      ];
      attachments = {
        img_folder = "Bin/attachments";
        img_text_func = {
          __raw = ''
            function(client, path)
              path = client:vault_relative_path(path) or path
              return string.format("![%s](%s)", path.name, path)
            end
          '';
        };
      };

      templates = {
        subdir = "templates";
        date_format = "%Y-%m-%d";
        time_format = "%H:%M";
      };

      completion = {
        nvim_cmp = true;
        min_chars = 2;
      };
      disable_frontmatter = true;
      frontmatter.enabled = false;
      # Use Neovim statusline instead of Obsidian UI
      ui.enable = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>oo";
      action = "<cmd>Obsidian open<CR>";
      options.desc = "Open note in Obsidian app";
    }
    {
      mode = "n";
      key = "<leader>on";
      action = "<cmd>Obsidian new<CR>";
      options.desc = "New note";
    }
    {
      mode = "n";
      key = "<leader>oq";
      action = "<cmd>Obsidian quick_switch<CR>";
      options.desc = "Quick switch note";
    }
    {
      mode = "n";
      key = "<leader>os";
      action = "<cmd>Obsidian search<CR>";
      options.desc = "Search notes";
    }
    {
      mode = "n";
      key = "<leader>ob";
      action = "<cmd>Obsidian backlinks<CR>";
      options.desc = "Show backlinks";
    }
    {
      mode = "n";
      key = "<leader>of";
      action = "<cmd>Obsidian follow_link<CR>";
      options.desc = "Follow link under cursor";
    }
    {
      mode = "n";
      key = "<leader>ot";
      action = "<cmd>Obsidian toc<CR>";
      options.desc = "Table of contents";
    }
    {
      mode = "n";
      key = "<leader>oT";
      action = "<cmd>Obsidian template<CR>";
      options.desc = "Insert template";
    }
    {
      mode = "n";
      key = "<leader>ol";
      action = "<cmd>Obsidian links<CR>";
      options.desc = "List links in note";
    }
    {
      mode = "n";
      key = "<leader>op";
      action = "<cmd>Obsidian paste_img<CR>";
      options.desc = "Paste image from clipboard";
    }
    {
      mode = "n";
      key = "<leader>or";
      action = "<cmd>Obsidian rename<CR>";
      options.desc = "Rename note";
    }
    {
      mode = "n";
      key = "<leader>ox";
      action = "<cmd>Obsidian toggle_checkbox<CR>";
      options.desc = "Toggle checkbox";
    }
  ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>o";
      group = "Obsidian";
      icon = "";
    }
  ];
}
