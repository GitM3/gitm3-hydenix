{ lib, ... }:
{
  home.file.".local/share/waybar/layouts/hyprdots/0.jsonc" = lib.mkForce {
    text = builtins.readFile ./waybar.jsonc;
    force = true;
    mutable = true;
  };
}
