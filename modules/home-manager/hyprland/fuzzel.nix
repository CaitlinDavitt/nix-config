{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    networkmanager_dmenu
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        font = "FiraCode:weight=normal:size=5";
        width = 25;
        lines = 10;
        # height = 400;
        dpi-aware = "yes";
        icon-thme = "Papirus-Dark";
        anchor = "center";
      };

      colors = {
        background = "2d353bff";
        text = "d3c6aaff";
        match = "a7c080ff";
        selection = "3d484dff";
        selection-text = "d3c6aaff";
        selection-match = "a7c080ff";
        border = "a7c080ff";
      };
    };
  };
}
