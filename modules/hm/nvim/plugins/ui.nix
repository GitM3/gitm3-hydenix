{
  plugins = {
    which-key = {
      enable = true;
      settings = {
        preset = "modern";
      };
    };
    gitsigns = {
      enable = true;
    };
    fugitive = {
      enable = true;
    };

    todo-comments = {
      enable = true;
    };
    neo-tree = {
      enable = true;
      settings = {
        sources = [
          "filesystem"
          "buffers"
          "git_status"
          "document_symbols"
        ];
        add_blank_line_at_top = false;

        filesystem = {
          bind_to_cwd = false;
          follow_current_file = {
            enabled = true;
          };
        };

        default_component_configs = {
          indent = {
            with_expanders = true;
            expander_collapsed = "󰅂";
            expander_expanded = "󰅀";
            expander_highlight = "NeoTreeExpander";
          };

          git_status = {
            symbols = {
              added = " ";
              conflict = "󰩌 ";
              deleted = "󱂥";
              ignored = " ";
              modified = " ";
              renamed = "󰑕";
              staged = "󰩍";
              unstaged = "";
              untracked = " ";
            };
          };
        };
      };
    };
    notify = {
      enable = true;
      settings = {
        render = "minimal";
      };
    };

    colorizer.settings = {
      enable = true;
    };

    image.enable = true;
    noice.enable = true;
    web-devicons.enable = true;
    leap.enable = true;
  };
}
