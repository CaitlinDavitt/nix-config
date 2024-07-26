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
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
