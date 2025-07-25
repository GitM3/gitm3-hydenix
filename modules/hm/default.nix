{ pkgs, inputs, ... }:

{
  imports = [
    ./keybinds.nix
    ./monitors.nix
    ./programs.nix
    ./yazi.nix
    ./hypr-usrprefs.nix
    ./hypr-idle.nix
    ./sync.nix
    ./redshift.nix
    ./nvim.nix
    ./direnv.nix
    ./zellij.nix
  ];

  home.sessionVariables = {
    # Ensure that the browser is available in the session
    BROWSER = "firefox";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
  home.packages = with pkgs; [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
    git-credential-manager
  ];
  programs.git = {
    enable = true;
    extraConfig = {
      # === Git Credential Manager (GCM) ===
      credential = {
        helper = "manager";
        credentialStore = "secretservice"; # Uses GNOME Keyring
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
      vim = false; # enable vim module
      default = "nvim"; # default text editor
    };
    fastfetch.enable = false; # fastfetch configuration
    firefox = {
      enable = true; # enable firefox module
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
      zsh = {
        enable = true;
        plugins = [
          "sudo"
          "zoxide"
          "git"
          "fzf"
          "direnv"
        ];
        configText = ''
          alias cat="bat"
          alias yazi="y"
          eval  "$(pay-respects zsh --alias)"
        '';
      };
      bash.enable = false; # enable bash shell
      fish.enable = false; # enable fish shell
      p10k.enable = true;
      starship.enable = false;
      fastfetch.enable = false;
    };
    social = {
      enable = false; # enable social module
      discord.enable = false; # enable discord module
      webcord.enable = false; # enable webcord module
      vesktop.enable = false; # enable vesktop module
    };
    spotify.enable = true; # enable spotify module
    swww.enable = true; # enable swww wallpaper daemon
    terminals = {
      enable = true; # enable terminals module
      kitty = {
        enable = true; # enable kitty terminal
        configText = builtins.readFile ./kitty.conf;
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
  services = {
    activitywatch = {
      enable = true;
      package = pkgs.aw-server-rust;
      extraOptions = [
        "--host"
        "127.0.0.1"
        "--port"
        "5600"
      ];
      watchers = {
        # --- stop ActivityWatch from spawning its classic X11 watchers -----------
        aw-watcher-window = {
          package = pkgs.activitywatch;
          settings = {
            enabled = false;
          }; # anything ≠ {} disables it
        };
        aw-watcher-afk = {
          package = pkgs.activitywatch;
          settings = {
            enabled = false;
          };
        };
        awatcher = {
          package = pkgs.awatcher; # already in 25.05 / unstable
          executable = "awatcher"; # default == name, could be "aw-awatcher"
          settings = {
            poll_time = 1;
            timeout = 300;
          }; # optional TOML file
          extraOptions = [
            "--host"
            "127.0.0.1"
            "--port"
            "5600"
          ];
        };
      };
    };

  };
}
