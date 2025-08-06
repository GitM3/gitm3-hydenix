{
  lib,
  ...
}:

{
  home.file = {

    ".local/lib/hyde/script_launcher.sh" = {
      executable = true;
      source = ../../resources/scripts/script_launcher.sh;
    };
    ".local/lib/hyde/dict.sh" = {
      executable = true;
      source = ../../resources/scripts/dict.sh;
    };
    # Override the keybindings.conf that Hydenix manages
    ".config/hypr/keybindings.conf" = lib.mkForce {
      source = ../../resources/config/keybinds.conf;
    };
  };
}
