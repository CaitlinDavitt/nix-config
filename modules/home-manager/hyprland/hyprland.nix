{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # waybar
    # waybar-mpris
    # wttrbar
    # wlogout
    networkmanager_dmenu
  ];

  # services = {
  #   swaync.enable = true;
  # };
}
