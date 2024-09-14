{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    swayidle
  ];

  services.swayidle = {
    enable = true;

    systemdTarget = "hyprland-session.target";

    events = [
      {
        event = "before-sleep";
        command = "/home/caitlin/.nix-profile/bin/swaylock -f";
      }
      {
        event = "lock";
        command = "/home/caitlin/.nix-profile/bin/swaylock -f";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "/home/caitlin/.nix-profile/bin/swaylock -f";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
