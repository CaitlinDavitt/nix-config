{
  pkgs,
  config,
  ...
}: {
  services = {
    swaync = {
      enable = true;
      settings {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 2;
        control-center-margin-bottom = 2;
        control-center-margin-right = 1;
        control-center-margin-left = 0;
        notification-2fa-action = true;
        notification-inline-replies = false;
        notification-icon-size = 48;
        notification-body-image-height = 160;
        notification-body-image-width = 200;

        timeout = 4;
        timeout-low = 2;
        timeout-critical = 6;

        fit-to-screen = false;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 200;
        hide-on-clear = false;
        hide-on-action = false;
        script-fail-notify = true;
        widgets = {
          "label";
          "mpris";
          "volume";
          "title";
          "notifications";
          "dnd";
        }
        
        
      };
    };
  };
}
