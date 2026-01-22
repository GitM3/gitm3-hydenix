{
  plugins.snacks = {
    enable = false;

    settings = {
      image = {
        resolve = {
          __raw = ''
            function(path, src)
              local api = require("obsidian.api")

              -- Only affect markdown files that are notes in the vault
              if api.path_is_note(path) then
                return api.resolve_attachment_path(src)
              end
            end
          '';
        };
      };
    };
  };
}
