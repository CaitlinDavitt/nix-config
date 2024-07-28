{
  pkgs,
  config,
  ...
}: {
  # home.packages = with pkgs.unstable; [
    # waybar
    # waybar-mpris
    # wttrbar
    # wlogout
  # ];

  services = {
    fuzzel.enable = true;
  };

  programs.fuzzel = {
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
      }
      colors.background = "ffffffff";
    }
    
  }
}
