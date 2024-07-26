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
  ];

  # services = {
  #   swaync.enable = true;
  # };
}
