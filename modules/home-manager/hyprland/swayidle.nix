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
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
  { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
    ]
  };
}
