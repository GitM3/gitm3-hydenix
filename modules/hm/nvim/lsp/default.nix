{
  lib,
  pkgs,
  ...
}: {
  plugins = {
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_fallback = "fallback";
          timeout_ms = 500;
        };
        notify_on_error = true;

        formatters_by_ft = {
          sh = [
            "shellcheck"
            "shfmt"
          ];
          python = [
            "isort"
            "black"
          ];
          docker = ["hadolint"];
          css = ["prettier"];
          html = ["prettier"];
          json = ["prettier"];
          lua = ["stylua"];
          markdown = ["prettier"];
          nix = ["alejandra"];
          yaml = ["prettier"];
        };
      };
    };

    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        diagnostic = {
          "<leader>E" = "open_float";
          "[" = "goto_prev";
          "]" = "goto_next";
          "<leader>do" = "setloclist";
        };
        lspBuf = {
          "K" = "hover";
          "gD" = "declaration";
          "gd" = "definition";
          "gr" = "references";
          "gI" = "implementation";
          "gy" = "type_definition";
          "<leader>ca" = "code_action";
          "<leader>cr" = "rename";
          "<leader>wl" = "list_workspace_folders";
          "<leader>wr" = "remove_workspace_folder";
          "<leader>wa" = "add_workspace_folder";
        };
      };
      preConfig = ''
        vim.diagnostic.config({
          virtual_text = false,
          severity_sort = true,
          float = {
            border = 'rounded',
            source = 'always',
          },
        })

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
          vim.lsp.handlers.hover,
          {border = 'rounded'}
        )

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          {border = 'rounded'}
        )
      '';
      postConfig = ''
              vim.diagnostic.config({
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "✘",
              [vim.diagnostic.severity.WARN]  = "▲",
              [vim.diagnostic.severity.HINT]  = "⚑",
              [vim.diagnostic.severity.INFO]  = "",
            }
          },
          virtual_text = true,
          underline = true,
          update_in_insert = false,
        })
      '';
      servers = {
        pyright.enable = true; # Python
        marksman.enable = true; # Markdown
        dockerls.enable = true; # Docker
        docker_compose_language_service.enable = true; # Docker compose
        bashls.enable = true; # Bash
        texlab = {
          enable = true;
          settings = {
            texlab = {
              build = {
                executable = "latexmk";
                args = ["-pdfdvi" "-interaction=nonstopmode"];
                onSave = true;
              };
              forwardSearch = {
                executable = "zathura";
                args = [
                  "--synctex-forward"
                  "%l:1:%f"
                  "%p"
                ];
              };
            };
          };
        };
        yamlls.enable = true; # YAML
      };
    };

    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        performance = {
          debounce = 150;
        };
        sources = [
          {name = "path";}
          {
            name = "nvim_lsp";
            keywordLength = 1;
          }
          {
            name = "buffer";
            keywordLength = 3;
          }
          {
            name = "luasnip";
            keywordLength = 3;
          }
        ];

        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        formatting = {
          fields = [
            "menu"
            "abbr"
            "kind"
          ];
          format = lib.mkForce ''
            function(entry, item)
              local menu_icon = {
                nvim_lsp = '[LSP]',
                luasnip = '[SNIP]',
                buffer = '[BUF]',
                path = '[PATH]',
              }

              item.menu = menu_icon[entry.source.name]
              return item
            end
          '';
        };

        mapping = lib.mkForce {
          "<Up>" = "cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select})";
          "<Down>" = "cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select})";

          "<C-p>" = "cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select})";
          "<C-n>" = "cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select})";

          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";

          "<C-e>" = "cmp.mapping.abort()";
          "<C-y>" = "cmp.mapping.confirm({select = true})";
          "<CR>" = "cmp.mapping.confirm({select = false})";

          "<C-f>" = ''
            cmp.mapping(
              function(fallback)
                if luasnip.jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end,
              { "i", "s" }
            )
          '';

          "<C-b>" = ''
            cmp.mapping(
              function(fallback)
                if luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end,
              { "i", "s" }
            )
          '';

          "<Tab>" = ''
            cmp.mapping(
              function(fallback)
                local col = vim.fn.col('.') - 1

                if cmp.visible() then
                  cmp.select_next_item(select_opts)
                elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                  fallback()
                else
                  cmp.complete()
                end
              end,
              { "i", "s" }
            )
          '';

          "<S-Tab>" = ''
            cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item(select_opts)
                else
                  fallback()
                end
              end,
              { "i", "s" }
            )
          '';
        };
        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
            zindex = 1001;
            scrolloff = 0;
            colOffset = 0;
            sidePadding = 1;
            scrollbar = true;
          };
          documentation = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
            zindex = 1001;
            maxHeight = 20;
          };
        };
      };
    };

    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-treesitter.enable = true;
    dap.enable = true;
    markdown-preview = {
      enable = true;
      settings.theme = "dark";
    };
    render-markdown.enable = true;
  };
}
