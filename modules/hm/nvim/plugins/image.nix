{
  plugins.image = {
    enable = true;

    settings = {
      integrations = {
        markdown = {
          enabled = true;
          clearInInsertMode = false;
          downloadRemoteImages = true;
          onlyRenderAtCursor = false;
          resolveImagePath = {
            __raw = ''
              function(document_path, image_path, fallback)
                local ok, obsidian = pcall(require, "obsidian")
                if not ok then
                  return fallback(document_path, image_path)
                end

                local client = obsidian.get_client()
                if not client then
                  return fallback(document_path, image_path)
                end

                -- Try resolving via Obsidian vault logic
                local rel = client:vault_relative_path(image_path)
                if rel and rel.filename then
                  if vim.fn.filereadable(rel.filename) == 1 then
                    return rel.filename
                  end
                end

                return fallback(document_path, image_path)
              end
            '';
          };
        };
      };

      backend = "kitty"; # change if needed
      maxWidth = 80;
      maxHeight = 20;
      maxWidthWindowPercentage = 50;
      maxHeightWindowPercentage = 50;

      windowOverlapClearEnabled = true;
    };
  };
  plugins.clipboard-image = {
    enable = true;

    settings = {
      default = {
        img_dir = "/home/zander/Pictures";

        img_name = {
          __raw = ''
            function()
              return os.date("%Y-%m-%d-%H-%M-%S")
            end
          '';
        };

        affix = "<\n  %s\n>";
      };

      markdown = {
        img_dir = "/home/zander/Documents/Obsidian/K4IZ3N/Bin/attachments";

        img_dir_txt = "";

        img_name = {
          __raw = ''
            function()
              return os.date("%Y-%m-%d-%H-%M-%S")
            end
          '';
        };
      };
    };
  };
}
