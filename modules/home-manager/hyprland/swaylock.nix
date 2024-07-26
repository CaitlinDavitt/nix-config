{
  pkgs,
  config,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      # color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 120;
      indicator-thickness = 10;
      # line-color = "ffffff";
      show-failed-attempts = true;
      screenshots = true;
      effect-blur = "4x2";
      effect-vignette = "0.2:0.5";
      clock = true;
      datestr = "%a %e.%m.%Y";
      timestr = "%k:%M";
      ignore-empty-password = false;
      indicator-caps-lock = true;
    };
  };
}
