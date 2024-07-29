# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  gBar,
  # fenix,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../modules/home-manager/default.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "caitlin";
    homeDirectory = "/home/caitlin";
  };

  # lib.mkForce.home.sessionVariables = {
  #   XCURSOR_THEME = "Bibata-Modern-Classic";
  #   XCURSOR_SIZE = "18";
  # };
  #
  lib.mkForce.gtk = {
    enable = true;
    theme = {
      name = "Everforest-Dark-BL";
      # package = pkgs.materia-theme;
    };
    # cursorTheme = {
    #   name = "everforest-cursors";
    #   size = 24;
    # };
    # font = {
    #   name = "Fira Code";
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  lib.mkForce.qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # lib.mkForce.pointerCursor = {
  #   name = "Bibata-Modern-Classic";
  #   package = pkgs.bibata-cursors;
  #   size = 16;
  #   x11.enable = true;
  # };
  #
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    gBar.defaultPackage.x86_64-linux
    pamixer
  ];

  stylix = {
    enable = true;
    targets = {
      kde = {
        enable = false;
      };
      gtk = {
        enable = true;
      };
      waybar = {
        enable = false;
      };
      fuzzel = {
        enable = false;
      };
    };
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 18;
    };
    fonts = {
      monospace = {
        name = "Fira Code";
        package = pkgs.fira-code;
      };

      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };

      sansSerif = {
        name = "Fira Sans";
        package = pkgs.fira;
      };

      serif = {
        name = "Linux Libertine";
        package = pkgs.libertine;
      };

      sizes = {
        applications = 10;
        # terminaal = 10;
      };
    };
  };

  #   lib.mkForce.home.pointerCursor = {
  #     gtk.enable = true;
  #     package = pkgs.bibata-cursors;
  #     name = "Bibata-Modern-Classic";
  #     size = 18;
  # };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  services = {
    # kdeconnect = {
    #   enable = true;
    # };
    mpd-mpris.enable = true;
  };

  xdg.mimeApps = {
    enable = true;

    associations.added = {
      "text/html" = ["floorp.desktop"];
      "x-scheme-handler/http" = ["floorp.desktop"];
      "x-scheme-handler/https" = ["floorp.desktop"];
      "x-scheme-handler/about" = ["floorp.desktop"];
      "x-scheme-handler/unknown" = ["floorp.desktop"];
      "image/jpeg" = ["org.gnome.gThumb.desktop"];
      "image/png" = ["org.gnome.gThumb.desktop"];
      "image/svg+xml" = ["org.gnome.gThumb.desktop"];
    };

    defaultApplications = {
      "text/html" = ["floorp.desktop"];
      "x-scheme-handler/http" = ["floorp.desktop"];
      "x-scheme-handler/https" = ["floorp.desktop"];
      "x-scheme-handler/about" = ["floorp.desktop"];
      "x-scheme-handler/unknown" = ["floorp.desktop"];
      "image/jpeg" = ["org.gnome.gThumb.desktop"];
      "image/png" = ["org.gnome.gThumb.desktop"];
      "image/gif" = ["org.gnome.gThumb.desktop"];
      "image/svg+xml" = ["org.gnome.gThumb.desktop"];
    };
  };

  lib.mkDefault.systemd.user.services = {
    lock = {
      Unit = {
        Description = "Lock the screen on resume from suspend.";
      };
      Install = {
        WantedBy = ["suspend.target"];
      };
      Service = {
        ExecStart = "/home/caitlin/.nix-profile/bin/swaylock";
        Type = "forking";
      };
    };

    swaync = {
      Unit = {
        After = "graphical-session-pre.target";
        ConditionEnvironment = "WAYLAND-DISPLAY";
        Description = "Sway notifications";
        Documentation = "https://github.com/ErikReider/SwayNotificationCenter";
        PartOf = "graphical-session.target";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
      Service = {
        BusName = "org.freedesktop.Notifications";
        ExecStart = "/home/caitlin/.nix-profile/bin/mpd-notification";
        Restart = "on-failure";
        Type = "dbus";
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
