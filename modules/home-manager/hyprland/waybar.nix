{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    waybar
    waybar-mpris
    wttrbar
    iniparser
    fftw
    fftw.dev
    cava
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
        ];
        spacing = 4;
        margin-borrom = 5;
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = ["custom/waybar-mpris" "cava"];
        modules-right = [
          # "idle_inhibitor"
          "backlight"
          "custom/weather"
          # "bluetooth"
          "pulseaudio/slider"
          "pulseaudio"
          "cpu"
          "memory"
          "disk"
          "temperature"
          "power-profiles-daemon"
          "battery"
          "network"
          "custom/notification"
          "clock"
          "custom/power"
          "w"
        ];

        # "sway/workspaces" = {
        #   disable-scroll = true;
        #   all-outputs = true;
        # };
        # "custom/hello-from-waybar" = {
        #   format = "hello {}";
        #   max-length = 40;
        #   interval = "once";
        #   exec = pkgs.writeShellScript "hello-from-waybar" ''
        #     echo "from within waybar"
        #   '';
        "custom/launcher" = {
          format = "";
          on-click = "~/.config/eww/dashboard/launch_dashboard.sh";
          on-click-right = "eww --config ~/.config/eww/dashboard/ kill";
        };

        "hyprland/workspaces" = {
          sort-by-name = true;
          on-click = "activate";
          disable-scroll = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "󰇮";
            # //"4": "";
            # //"5": "";
            "6" = "󰙯";
            "7" = "";
            "urgent" = "";
            # //"active": "";
            # //"default": "";
            "default" = "";
          };
        };

        "hyprland/window" = {
          max-length = 60;
          format = "{}";
          escape = true;
        };

        "custom/waybar-mpris" = {
          return-type = "json";
          exec = "waybar-mpris --position --autofocus --play \" \" --pause \" \" --interpolate --order SYMBOL:TITLE:POSITION";
          on-click = "waybar-mpris --send toggle";
          on-click-right = "waybar-mpris --send player-next";
          on-scroll-up = "waybar-mpris --send next";
          on-scroll-down = "waybar-mpris --send prev";
          escape = true;
          max-length = 30;
        };

        cava = {
          # "cava_config" = "$XDG_CONFIG_HOME/cava/cava.conf";
          "framerate" = 50;
          "autosens" = 1;
          "sensitivity" = 1;
          "bars" = 14;
          "lower_cutoff_freq" = 50;
          "higher_cutoff_freq" = 10000;
          "method" = "pipewire";
          "source" = "auto";
          "stereo" = true;
          "reverse" = false;
          "bar_delimiter" = 0;
          "monstercat" = false;
          "waves" = false;
          "noise_reduction" = 0.77;
          "input_delay" = 2;
          "format-icons" = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          "actions" = {
            "on-click-right" = "mode";
          };
        };

        "custom/notification" = {
          "tooltip" = false;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = " ";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = " ";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = " ";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = " ";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
        };

        clock = {
          timezone = "America/Chicago";
          tooltip-format = "<big>{:%B %Y}</big>\n <tt><small>{calendar}</small></tt>";
          format = "{:%H:%M}";
          format-alt = "  {:%a %b %d, %G}";
          interval = 1;
        };

        idle_inhibitior = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        backlight = {
          "format" = "{icon}{percent}%";
          "format-icons" = [" "];
          "interval" = 0.2;
          # "device" = "intel_backlight";
          "on-scroll-down" = "exec ~/.config/hypr/scripts/brightness.sh --dec";
          "on-scroll-up" = "exec ~/.config/hypr/scripts/brightness.sh --inc";
        };

        "custom/weather" = {
          format = " {}";
          tooltip = true;
          interval = 3600;
          exec = "exec ~/.config/hypr/scripts/waybar-wttr.sh";
          return-type = "json";
        };

        "bluetooth" = {
          #"controller" = "controller1"; # specify the alias of the controller if there are more than 1 on the system
          "format" = " {status}";
          "format-disabled" = ""; # an empty format will hide the module
          "format-connected" = " {num_connections}";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "on-click" = "$HOME/.config/hypr/scripts/tofi_blue";
        };

        "pulseaudio" = {
          # "scroll-step"= 1; // %, can be a float
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon}{volume}% ";
          "format-bluetooth-muted" = "{icon} {format_source}";
          "format-muted" = "{format_source}";
          "format-source" = "";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "󰋋 ";
            "hands-free" = "󰋎 ";
            "headset" = "󰋎 ";
            "phone" = "󰏲 ";
            "portable" = "󰏲 ";
            "car" = "󰄋 ";
            "default" = ["󰕿" "󰖀" "󰕾"];
          };
          "on-click" = "pavucontrol";
        };
        "pulseaudio/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "horizontal";
        };

        "cpu" = {
          "interval" = 5;
          "format" = " {usage}%";
          "on-click" = "kitty btop";
        };

        "memory" = {
          "interval" = 10;
          "format" = " {used:0.1f}G";
        };

        "disk" = {
          "interval" = 30;
          "format" = "󰆼 {free}";
          "unit" = "GiB";
          "path" = "/";
        };

        "temperature" = {
          #"thermal-zone" = 2,
          "hwmon-path" = "/sys/class/thermal/thermal_zone11/temp";
          "critical-threshold" = 80;
          # "format-critical"= "{icon} {temperatureC}°C";
          "format" = "{icon} {temperatureC}°C";
          "format-icons" = ["" "" ""];
        };

        "power-profiles-daemon" = {
          "format" = "{icon}";
          "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
          "tooltip" = true;
          "format-icons" = {
            "default" = " ";
            "performance" = " ";
            "balanced" = " ";
            "power-saver" = " ";
          };
        };

        "battery" = {
          "states" = {
            # "good"= 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = "󰚥 {capacity}%";
          "format-plugged" = "󰚥 {capacity}%";
          "format-alt" = "{icon} {time}";
          # "format-good"= "", # An empty format will hide the module
          "format-full" = "";
          "format-icons" = ["󰁺" "󰁼" "󰁾" "󰂁" "󰁹"];
        };

        "network" = {
          "interface" = "wlan0";
          "format" = "{ifname}";
          "format-wifi" = "{signalStrength}%  ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "format-disconnected" = ""; #An empty format will hide the module.
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 20;
          "on-click-right" = "exec ~/.config/hypr/scripts/wofi_wifi";
        };
        "custom/power" = {
          "format" = " ";
          "on-click" = "wlogout";
          # "on-click-right" = "killall tofi";
        };
      };
    };
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
        /* Installing `otf-font-awesome` is required for icons */
        font-family: "Fira Code", "Font Awesome 5 Free", Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
      }

      /* > The bar itself */
      window#waybar {
        background-color: transparent;
        color: @text;
        border-radius: 0px 0px 5px 5px;
        /* padding: 0px; */
        margin: 10px;
      }
      .modules-right {
        border: 1px @fg;
        border-style: solid;
        box-shadow: 3px 3px 3px 1px rgba(10, 10, 12, 0.7);
        background-color: @bg;
        border-radius: 12px;
        padding: 2px 5px 2px 5px;
      }
      .modules-left {
        border: 1px @fg;
        border-style: solid;
        box-shadow: 3px 3px 3px 1px rgba(10, 10, 12, 0.7);
        background-color: @bg;
        border-radius: 12px;
        padding: 2px 5px 2px 5px;
      }
      .modules-center {
        border: 1px @fg;
        border-style: solid;
        box-shadow: 3px 3px 3px 1px rgba(10, 10, 12, 0.7);
        background-color: @bg;
        border-radius: 12px;
        padding: 5px;
        padding: 0px 5px 0px 5px;
        padding: 2px 5px 2px 5px;
      }
      window > box {
        background-color: transparent;
        border-radius: 5px;
        padding: 3px 3px;
        margin: 2px;
      }

      /* > Buttons */
      button {
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -2px transparent;
        /* Avoid rounded borders under each button name */
        border: none;
      }
      button:hover {
        background: inherit;
        box-shadow: inset 0 -2px @fg;
      }

      /* A lot of things here */
      #clock,
      #mpris,
      #power-profiles-daemon,
      #battery,
      #cpu,
      #disk,
      #memory,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #tray,
      #network,
      /* > Workspaces */
      #workspaces button {
        border-radius: 0;
        padding: 0 4px;
        color: @text;
      }

      #workspaces button.active {
        background-color: @base;
        box-shadow: inset 0 -3px @text;
      }

      #workspaces button.urgent {
        background-color: @red;
        color: @text;
      }

      #window,
      #workspaces {
        margin: 4px 2px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #custom-launcher {
        color: @blue;
        font-size: 20px;
        margin-left: 3px;
        margin-right: 6px;
      }

      /* > Wallpaper */
      #custom-wallpaper {
        color: @red;
        font-size: 20px;
        margin-left: 3px;
        margin-right: 8px;
      }

      /* > Idle Inhibitor */
      #idle_inhibitor {
        color: @orange;
      }

      #idle_inhibitor.activated {
        border-width: 1px;
        border-color: @red;
        border-style: solid;
        border-radius: 5px;
      }

      /* > Backlight */
      #backlight {
        color: @orange;
      }

      /* > Weather */
      #custom-weather {
        color: @orange;
      }

      /* > Bluetooth */
      #bluetooth {
        color: @yellow;
      }

      /* > Pulseaudio */
      #pulseaudio {
        color: @yellow;
      }
      #pulseaudio.muted {
        border-width: 1px;
        border-color: @red;
        border-style: solid;
        border-radius: 5px;
      }

      #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      #pulseaudio-slider trough {
        min-height: 5px;
        min-width: 50px;
        border-radius: 5px;
        background-color: @bg_dim;
      }

      #pulseaudio-slider highlight {
        min-width: 5px;
        border-radius: 5px;
        background-color: @yellow;
      }

      /* > CPU
         >- Shows CPU load. */
      #cpu {
        color: @green;
      }

      /* > Disk
         >- Shows Disk free. */
      #disk {
        color: @green;
      }

      /* > Memory */
      #memory {
        color: @green;
      }

      /* > Temperature
         >- Shows the temperature of a thermal zone in /sys/class/thermal/ */
      #temperature {
        color: @aqua;
      }
      #temperature.critical {
        border-width: 1px;
        border-color: @red;
        border-style: solid;
        border-radius: 5px;
      }

      #power-profiles-daemon {
        color: @aqua;
      }

      /* > Battery
         >- Shows battery level. */
      #battery {
        color: @aqua;
      }
      /* >> Charging */
      #battery.charging,
      #battery.plugged {
        border-width: 1px;
        border-color: @green;
        border-style: solid;
        border-radius: 5px;
      }
      /* >> Other */
      /* --- Blinking animation */
      @keyframes blink {
        to {
          background-color: @red;
          border-width: 2px;
          color: @text;
        }
      }
      /* --- When the battery is too low
         -- and not charging: */
      #battery.critical:not(.charging) {
        background-color: @bg;
        color: @red;
        border-color: @red;
        border-radius: 5px;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      /* > Clock */
      #clock {
        color: @purple;
      }

      /* > Network */
      #network {
        color: @text;
        /* padding-right: 7px; */
      }
      #network.disconnected {
        border-color: @text;
        border-style: solid;
        border-radius: 1px
      }

      /* > Power Menu */
      #custom-power {
        color: @purple;
        /* font-size: 18px; */
        /* padding-right: 10px; */
      }

      #custom-notification {
        color: @purple;
      }

      /* > Tooltips */
      tooltip {
        background-color: #343f44;
        border-radius: 5px;
        border-style: solid;
        border: 3px #d3c6aa;
      }

      tooltip label {
        color: #d3c6aa;
      }

      /* UNUSED */

      /* > Tray
         >- For applets and such. */
      #tray {
        color: @blue;
      }
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        color: @red;
      }
      label:focus {
        background-color: black;
      }

      /* > Pipewire audio
         >- This unchanged as I use PulseAudio. */
      #wireplumber {
        background-color: #fff0f5;
        color: #000000;
      }
      #wireplumber.muted {
        background-color: #f53c3c;
      }

      #custom-pia-vpn {
        color: @blue;
      }

    '';
  };
}
