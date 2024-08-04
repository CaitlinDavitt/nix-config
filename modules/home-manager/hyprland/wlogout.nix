{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # wlogout
  ];
  xdg.configFile."wlogout/icons/lock.png".source = ./icons/lock.png;
  xdg.configFile."wlogout/icons/logout.png".source = ./icons/logout.png;
  xdg.configFile."wlogout/icons/suspend.png".source = ./icons/suspend.png;
  xdg.configFile."wlogout/icons/hibernate.png".source = ./icons/hibernate.png;
  xdg.configFile."wlogout/icons/reboot.png".source = ./icons/reboot.png;
  xdg.configFile."wlogout/icons/shutdown.png".source = ./icons/shutdown.png;
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "swaylock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "Logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "p";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
        "keybind" = "s";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
    ];

    style = ''
      @define-color bg     #2D353B;
      @define-color bg_dim #232A2E;

      @define-color text     #d3c6aa;

      @define-color red       #E67E80;
      @define-color orange    #E69875;
      @define-color yellow    #DBBC7F;
      @define-color green     #A7C080;
      @define-color blue      #7FBBB3;
      @define-color aqua      #83C092;
      @define-color purple    #D699B6;

      * {
      	background-image: none;
      	box-shadow: none;
      }

      window {
      	background-color: rgba(12, 12, 12, 0.9);
      }

      button {
        border-radius: 5px;
        margin: 10px;
        border-color: @fg;
      	text-decoration-color: @fg;
        color: @fg;
      	background-color: @bg;
      	border-style: solid;
      	border-width: 1px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
        font-size: 25px;
      }

      button:focus, button:active, button:hover {
      	background-color: @bg_dim;
      	outline-style: none;
      }

      #lock {
          color: @red;
          background-image: image(url("/home/caitlin/.config/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));

      }

      #logout {
          color: @orange;
          background-image: image(url("/home/caitlin/.config/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
          color: @yellow;
          background-image: image(url("/home/caitlin/.config/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
          color: @green;
          background-image: image(url("/home/caitlin/.config/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
          color: @blue;
          background-image: image(url("/home/caitlin/.config/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          color: @purple;
          background-image: image(url("/home/caitlin/.config/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
      }

    '';
  };
}
