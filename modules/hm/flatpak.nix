# home.nix
{ lib, ... }:
{

  # Add a new remote. Keep the default one (flathub)
  # services.flatpak.remotes = lib.mkOptionDefault [{
  #   name = "flathub-beta";
  #   location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  # }];

  services = {
    flatpak = {
      update.auto.enable = false;
      uninstallUnmanaged = false;
      packages = [
        {
          appId = "com.com.usebottles.bottles";
          origin = "flathub";
        }
        {
          appId = "com.com.github.tchx84.Flatseal";
          origin = "flathub";
        }
      ];
      overrides = {
        "com.com.usebottles.bottles".Context = {
          filesystems = [
            "xdg-run/pipewire-0"
          ];
        };
      };
    };
  };

}
