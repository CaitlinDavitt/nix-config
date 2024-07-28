{
  pkgs,
  config,
  ...
}: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-height = 860;
      control-center-width = 380;
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;
      notification-window-width = 350;

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
      widgets = [
        "label"
        "mpris"
        "volume"
        "title"
        "notifications"
        "dnd"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " ";
        };
        dnd = {
          text = "Do not disturb";
        };
        label = {
          max-lines = 1;
          text = "Notifications";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
        volume = {
          label = "󰕾";
          show-perapp = true;
        };
      };
    };
    style = ''
              @define-color cc-bg #2d353b;
      @define-color noti-border-color #2d353b;
      @define-color noti-bg #343f44;
      @define-color noti-bg-darker #343f44;
      @define-color noti-bg-hover rgb(27, 27, 43);
      @define-color noti-bg-focus rgba(27, 27, 27, 0.6);
      @define-color text-color #d3c6aa;
      @define-color text-color-disabled #bdae93;
      @define-color bg-selected #3d484d;
      @define-color accent #a7c080;

      * {
          font-family: Fira Code;
          font-weight: bold;
      	  font-size: 14px
      }

      .control-center .notification-row:focus,
      .control-center .notification-row:hover {
          opacity: 1;
          background: @noti-bg-darker
      }

      .notification-row {
          outline: none;
          margin: 5px;
          padding: 0;
      }

      .notification {
          background: transparent;
          margin: 0px;
          /* border-radius: 16px; */
      }

      .notification-content {
          background: @cc-bg;
          padding: 7px;
          border-radius: 16px;
          border: 2px solid @accent;
          margin: 0;
      }
      .notification-content .image {
        border-radius: 0px;
        padding-right: 7px;
      }

      .close-button {
          background: @accent;
          color: @cc-bg;
          text-shadow: none;
          padding: 0;
          border-radius: 0px;
          margin-top: 5px;
          margin-right: 5px;
      }

      .close-button:hover {
          box-shadow: none;
          background: #3d484d;
          transition: all .15s ease-in-out;
          border: none
      }

      .notification-action {
          color: #ebdbb2;
          border: 2px solid #85796f;
          border-top: none;
          border-radius: 0px;
          background: #2d353b;
      }

      .notification-default-action:hover,
      .notification-action:hover {
          color: #ebdbb2;
          background: #2d353b;
      }

      .summary {
      	padding-top: 7px;
        font-size: 13px;
        color: #ebdbb2;
      }

      .time {
          font-size: 11px;
          color: @accent;
          margin-right: 24px
      }

      .body {
          font-size: 12px;
          color: #ebdbb2;
      }

      .control-center {
          background: @cc-bg;
          border: 2px solid #85796f;
          border-radius: 16px;
      }

      .control-center-list {
          background: transparent
      }

      .control-center-list-placeholder {
          opacity: .5
      }

      .floating-notifications {
          background: transparent
      }

      .blank-window {
          background: alpha(black, 0.1)
      }

      .widget-title {
          color: #d3c6aa;
          background: @noti-bg-darker;
          padding: 5px 10px;
          margin: 10px 10px 5px 10px;
          font-size: 1.5rem;
          border-radius: 5px;
      }

      .widget-title>button {
          font-size: 1rem;
          color: @text-color;
          text-shadow: none;
          background: @noti-bg;
          box-shadow: none;
          border-radius: 5px;
      }

      .widget-title>button:hover {
          background: @accent;
          color: @cc-bg;
      }

      .widget-dnd {
          background: @noti-bg-darker;
          padding: 5px 10px;
          margin: 5px 10px 10px 10px;
          border-radius: 5px;
          font-size: large;
          color: #f2e5bc;
      }

      .widget-dnd>switch {
          border-radius: 4px;
          background: #2d353b;
      }

      .widget-dnd>switch:checked {
          background: @accent;
          border: 1px solid @accent;
      }

      .widget-dnd>switch slider {
          background: #56635f;
          border-radius: 5px
      }

      .widget-dnd>switch:checked slider {
          background: @cc-bg;
          border-radius: 5px
      }

      .widget-label {
          margin: 10px 10px 5px 10px;
      }

      .widget-label>label {
          font-size: 1rem;
          color: @text-color;
      }

      .widget-mpris {
          color: @text-color;
          background: @noti-bg-darker;
          padding: 5px 10px 0px 0px;
          margin: 5px 10px 5px 10px;
          border-radius: 0px;
      }

      .widget-mpris > box > button {
          border-radius: 5px;
      }

      .widget-mpris-player {
          padding: 5px 10px;
          margin: 10px
      }

      .widget-mpris-title {
          font-weight: 700;
          font-size: 1.25rem
      }

      .widget-mpris-subtitle {
          font-size: 1.1rem
      }

      .widget-buttons-grid {
          font-size: x-large;
          padding: 5px;
          margin: 5px 10px 10px 10px;
          border-radius: 5px;
          background: @noti-bg-darker;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button {
          margin: 3px;
          background: @cc-bg;
          border-radius: 5px;
          color: @text-color
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
          background: @accent;
          color: @cc-bg;
      }

      .widget-menubar>box>.menu-button-bar>button {
          border: none;
          background: transparent
      }

      .topbar-buttons>button {
          border: none;
          background: transparent
      }
    '';
  };
}
