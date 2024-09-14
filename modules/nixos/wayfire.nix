{
  pkgs,
  config,
  ...
}: {
  programs.wayfire = {
    enable = true;
    # settings = {
    #   main = {
    #     terminal = "${pkgs.kitty}/bin/kitty";
    #     layer = "overlay";
    #     font = "FiraCode:weight=normal:size=5";
    #     width = 25;
    #     lines = 10;
    #     # height = 400;
    #     dpi-aware = "yes";
    #     icon-theme = "Papirus-Dark";
    #     anchor = "center";
    #   };

    #   colors = {
    #     background = "2d353bff";
    #     text = "d3c6aaff";
    #     match = "a7c080ff";
    #     selection = "3d484dff";
    #     selection-text = "d3c6aaff";
    #     selection-match = "a7c080ff";
    #     border = "a7c080ff";
    #   };
    # };
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
      firedecor
    ];
  };
}
