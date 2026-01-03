{lib, ...}: {
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
      key = "<C-j>";
      action = "<cmd>wincmd j<cr>";
      options.desc = "Window down";
    }

    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>wincmd k<cr>";
      options.desc = "Window up";
    }
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      options.desc = "Increase height";
    }

    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      options.desc = "Decrease height";
    }

    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      options.desc = "Decrease width";
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<cmd>vsplit<cr>";
      options.desc = "Vertical split";
    }

    {
      mode = "n";
      key = "<leader>-";
      action = "<cmd>split<cr>";
      options.desc = "Horizontal split";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      options.desc = "Increase width";
    }
    #---------------------------------------------
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
    #-------------------------------------------
    {
      mode = "n";
      key = "<leader>bb";
      action = "<cmd>Telescope buffers<cr>";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
      options.desc = "Delete buffer";
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bnext<cr>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bprevious<cr>";
      options.desc = "Previous buffer";
    }
    #---------------------------------------
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
    #------------------------------------------------------
    {
      mode = "n";
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<cr>";
      options.desc = "Go to definition";
    }

    {
      mode = "n";
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
      options.desc = "Go to declaration";
    }

    {
      mode = "n";
      key = "gr";
      action = "<cmd>Telescope lsp_references<cr>";
      options.desc = "References";
    }

    {
      mode = "n";
      key = "gi";
      action = "<cmd>Telescope lsp_implementations<cr>";
      options.desc = "Implementations";
    }
    {
      mode = "n";
      key = "<leader>ls";
      action = "<cmd>Telescope lsp_document_symbols<cr>";
      options.desc = "Document symbols";
    }

    {
      mode = "n";
      key = "<leader>lS";
      action = "<cmd>Telescope lsp_workspace_symbols<cr>";
      options.desc = "Workspace symbols";
    }

    {
      mode = "n";
      key = "<leader>lr";
      action = "<cmd>lua vim.lsp.buf.rename()<cr>";
      options.desc = "Rename symbol";
    }
    #------------------------------------------
    {
      mode = ["n" "x" "o"];
      key = "s";
      action = "<Plug>(leap-forward)";
      options.desc = "Leap forward";
    }

    {
      mode = ["n" "x" "o"];
      key = "S";
      action = "<Plug>(leap-backward)";
      options.desc = "Leap backward";
    }
  ];
}
