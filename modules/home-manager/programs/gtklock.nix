{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # Gnome icons for gtklock
    # gnome.adwaita-icon-theme
    # gtklock
    # gtklock-userinfo-module
    # gtklock-powerbar-module
    # gtklock-playerctl-module
  ];
}
