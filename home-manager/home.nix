# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  pkgs-unsatable,
  fenix,
  gBar,
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

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "Breeze";
  };

  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    gBar.defaultPackage.x86_64-linux
    pamixer
  ];

  stylix.targets.kde.enable = false;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

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
    "image/xvg+xml" = ["org.gnome.gThumb.desktop"];
    };

  };


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
