{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # waybar
    # waybar-mpris
    # wttrbar
  ];

  # services = {
  #   swaync.enable = true;
  # };
}
