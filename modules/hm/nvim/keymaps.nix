{
  keymaps = [
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Window left";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Window right";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = ":Neotree toggle<CR>";
      options.desc = "Open Neotree";
    }
    {
      mode = "n";
      key = "<leader>y";
      action = ":Yazi<CR>";
      options.desc = "Open Yazi";
    }
    {
      mode = "n";
      key = "<leader><leader>";
      action = "<cmd>Telescope find_files<cr>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fw";
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Find word (ripgrep)";
    }
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Telescope buffers<cr>";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>1";
      action.__rawLua = ''
        require("harpoon"):list():select(1)
      '';
    }
    {
      mode = "n";
      key = "<leader>2";
      action.__rawLua = ''
        require("harpoon"):list():select(2)
      '';
    }
    {
      mode = "n";
      key = "<leader>3";
      action.__rawLua = ''
        require("harpoon"):list():select(3)
      '';
    }
    {
      mode = "n";
      key = "<leader>hh";
      action.__rawLua = ''
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      '';
    }
    {
      mode = "n";
      key = "<leader>ht";
      action.__rawLua = ''
        require("telescope").extensions.harpoon.marks()
      '';
    }

    {
      mode = "n";
      key = "<leader>ha";
      action.__rawLua = ''
        require("harpoon"):list():add()
      '';
      options.desc = "Harpoon add file";
    }
    {
      mode = "n";
      key = "<leader>uu";
      action = "<cmd>UndotreeToggle<cr>";
      options.desc = "Undo tree";
    }

    {
      mode = "n";
      key = "<leader>ll";
      action = "<cmd>VimtexCompile<cr>";
      options.desc = "Compile";
    }

    # Stop compilation
    {
      mode = "n";
      key = "<leader>lk";
      action = "<cmd>VimtexStop<cr>";
      options.desc = "Stop compile";
    }

    # Open PDF / forward search
    {
      mode = "n";
      key = "<leader>lv";
      action = "<cmd>VimtexView<cr>";
      options.desc = "View PDF";
    }

    # Clean auxiliary files
    {
      mode = "n";
      key = "<leader>lc";
      action = "<cmd>VimtexClean<cr>";
      options.desc = "Clean aux files";
    }

    # Clean all (including PDF)
    {
      mode = "n";
      key = "<leader>lC";
      action = "<cmd>VimtexClean!<cr>";
      options.desc = "Clean all";
    }

    # Toggle table of contents
    {
      mode = "n";
      key = "<leader>lt";
      action = "<cmd>VimtexTocToggle<cr>";
      options.desc = "Table of contents";
    }

    # Show VimTeX info (diagnostics, engine, viewer)
    {
      mode = "n";
      key = "<leader>li";
      action = "<cmd>VimtexInfo<cr>";
      options.desc = "VimTeX info";
    }
  ];
}
