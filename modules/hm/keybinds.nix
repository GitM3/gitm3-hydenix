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
    # ".config/hyde/themes/Decay Green/wallpapers/cat.png" = {
    #   source = ../../resources/wallpapers/cat.png;
    # };
  };
  home.activation.copyWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -f "$HOME/.config/hyde/themes/Decay Green/wallpapers/cat.png"
    cp ${../../resources/wallpapers/cat.png} "$HOME/.config/hyde/themes/Decay Green/wallpapers/cat.png"
  '';
}
