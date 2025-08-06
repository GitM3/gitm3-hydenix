{ lib, ... }:
{
  home.file.".local/share/waybar/layouts/hyprdots/0.jsonc" = lib.mkForce {
    text = builtins.readFile ../../resources/config/waybar.jsonc;
    force = true;
    mutable = true;
  };
}
