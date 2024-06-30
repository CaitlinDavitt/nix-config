{ 
  inputs
  outputs
  lib
  config, 
  pkgs, 
  pkgs-unstable, 
  fenix, 
  gBar, 
  ... 
}: {
  home.username = "caitlin";
  home.homeDirectory = "/home/caitlin";

  imports = [
    # ./programs/sunshine.nix
    ../modules/home-manager/default.nix
  ];


  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallckpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #"Xcursor.size" = 24;
  #  "Xft.dpi" = 172;
  #};

  # gtk = {
  #   enable = true;
  #   theme = {
  #     # name = "Everforest-Dark-BL";
  #     #package = pkgs.materia-theme;
  #   };
  #   cursorTheme = {
  #     name = "everforest-cursors";
  #     size = 24;
  #   };
  #   font = {
  #     # name = "Fira Code";
  #   };
  # };

  # dconf.settings = {
  # "org/gnome/desktop/interface" = {
  #   color-scheme = "prefer-dark";
  # };
  # };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "adwaita";
  #   style.name = "adwaita-dark";
  # };
    qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "Breeze";
  };

  # xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
  #   General.theme = "Catppuccin-Macchiato-Blue";
  # };



  # xdg.mimeApps = {
  # enable = true;
  # 
  # defaultApplications = {
  #   "text/html" = "floorp";
  #   "x-scheme-handler/http" = "floorp";
  #   "x-scheme-handler/https" = "floorp";
  #   "x-scheme-handler/about" = "floorp";
  #   "x-scheme-handler/unknown" = "floorp";
  #   };
  # };



  # basic configuration of git, please change to your own
  #programs.git = {
  #  enable = true;
    #userName = "Caitlin Davitt";
    #userEmail = "cai";
  #};

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    gBar.defaultPackage.x86_64-linux
    pamixer
  ];

  stylix.targets.kde.enable = false;



  # services.sunshine.enable = true;






  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
