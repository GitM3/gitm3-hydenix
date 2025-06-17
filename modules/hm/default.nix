{ pkgs, inputs, ... }:

{
  imports = [
  ./keybinds.nix
  ./monitors.nix
  ./programs.nix
  ./yazi.nix
  ./hypr-usrprefs.nix
  ];

  # home-manager options go here
  home.packages = with pkgs; [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
    git-credential-manager
# TODO: include later
#    inputs.nvix.packages.${pkgs.system}.core
  ];
        programs.git = {
        enable = true; 
        extraConfig = {
      # === Git Credential Manager (GCM) ===
        credential = {
          helper = "manager";
          credentialStore = "secretservice";  # Uses GNOME Keyring
          autoDetectTimeout = 30;
        };
        
        "credential \"https://github.com\"" = {
          provider = "github";
          helper = "manager";
        };
        # === Git settings for better OAuth experience ===
        init.defaultBranch = "main";
        pull.rebase = false;
        push.autoSetupRemote = true;
        };
      };

  # hydenix home-manager options go here
  hydenix.hm = {
    #! Important options
    enable = true;

     # ! Below are defaults

      comma.enable = true; # useful nix tool to run software without installing it first
      dolphin.enable = true; # file manager
      editors = {
        enable = true; # enable editors module
        neovim = false; # enable neovim module
        vscode = {
          enable = true; # enable vscode module
          wallbash = true; # enable wallbash extension for vscode
        };
        vim = true; # enable vim module
        default = "nvim"; # default text editor
      };
      fastfetch.enable = true; # fastfetch configuration
      firefox = {
        enable = true; # enable firefox module
        useHydeConfig = false; # use hyde firefox configuration and extensions
        useUserChrome = true; # if useHydeConfig is true, apply hyde userChrome CSS customizations
        useUserJs = true; # if useHydeConfig is true, apply hyde user.js preferences
        useExtensions = true; # if useHydeConfig is true, install hyde firefox extensions
      };
      hyde.enable = true; # enable hyde module
      hyprland = {
          enable = true;
        };
      lockscreen = {
        enable = true; # enable lockscreen module
        hyprlock = true; # enable hyprlock lockscreen
        swaylock = false; # enable swaylock lockscreen
      };
      notifications.enable = true; # enable notifications module
      qt.enable = true; # enable qt module
      rofi.enable = true; # enable rofi module
      screenshots = {
        enable = true; # enable screenshots module
        grim.enable = true; # enable grim screenshot tool
        slurp.enable = true; # enable slurp region selection tool
        satty.enable = true; # enable satty screenshot annotation tool
        swappy.enable = false; # enable swappy screenshot editor
      };
      shell = {
        enable = true; # enable shell module
        zsh.enable = true; # enable zsh shell
        zsh.configText = ""; # zsh config text
        bash.enable = false; # enable bash shell
        fish.enable = false; # enable fish shell
        pokego.enable = false; # enable Pokemon ASCII art scripts
      };
      social = {
        enable = false; # enable social module
        # discord.enable = false; # enable discord module
        # webcord.enable = false; # enable webcord module
        # vesktop.enable = false; # enable vesktop module
      };
      spotify.enable = true; # enable spotify module
      swww.enable = true; # enable swww wallpaper daemon
      terminals = {
        enable = true; # enable terminals module
        kitty = {
          enable = true; # enable kitty terminal
          configText = ""; # kitty config text
        };
      };
      theme = {
        enable = true; # enable theme module
        active = "Decay Green"; # active theme name
        themes = [
          "Catppuccin Mocha"
          "Catppuccin Latte"
          "Decay Green"
          "Tokyo Night"
          "Graphite Mono"
          "Frosted Glass"
          "Moonlight"
          "Nordic Blue"
          "One Dark"
          "Gruvbox Retro"
        ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
      };
      waybar.enable = true; # enable waybar module
      wlogout.enable = true; # enable wlogout module
      xdg.enable = true; # enable xdg module
  };
}
