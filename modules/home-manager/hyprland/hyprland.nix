{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # waybar
    # waybar-mpris
    # wttrbar
    # wlogout
  ];

  systemd.user.services = {
    swww = {
      Unit = {
        Description = "A solution to your Wayland Wallpaper Woes";
        PartOf = "wayland-sesion.target";
        After = "wayland-session.target";
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = "/home/caitlin/.nix-profile/bin/swww-daemon";
      };
      Install = {
        WantedBy = ["wayalnd-session.target"];
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    # wayland.windowManager.hyprland.plugins = [
    # pkgs.unstable.hyprlandPlugins.hyprspace
    # ];

    extraConfig = ''
          #-- Monitor Settings ------------------------------------------
      # monitor = DP-3, highres, auto, 1

      monitor = eDP-1, 2256x1504@60,0x0, 1.175
      monitor = DP-3, 1920x1080@75, auto, 1
      monitor = DP-3, transform, 3
      workspace = eDP-1, 1
      # workspace = DP-3, 6

      workspace = 1, monitor eDP-1
      workspace = 2, monitor eDP-1
      workspace = 3, monitor eDP-1
      workspace = 4, monitor eDP-1
      workspace = 5, monitor eDP-1
      workspace = 6, monitor DP-1
      workspace = 7, monitor DP-1
      workspace = 8, monitor DP-1
      workspace = 9, monitor DP-1
      workspace = 10, monitor DP-1


      #-- Input ----------------------------------------------------
      # Configure mouse and touchpad here.
      input {
        kb_layout = de
        kb_variant = us
        kb_model =
        kb_options =
        kb_rules =
        follow_mouse = 1#2E3235
        natural_scroll = 0
        #force_no_accel = 0
        left_handed = false
        repeat_rate = 40
        repeat_delay = 250
        numlock_by_default = 1
        #disable_while_typing = true

        touchpad {
          disable_while_typing=false
          middle_button_emulation=false
          clickfinger_behavior=false
          natural_scroll=false
        }
      }

      gestures {
        workspace_swipe = true
        #workspace_swipe_fingers = 3
        #workspace_swipe_distance = 300
        workspace_swipe_invert = false
        workspace_swipe_min_speed_to_force = 20
        workspace_swipe_cancel_ratio = 0.75
      }

      #-- Misc Settings --------------------------------------------
      misc {
        vfr = true
        vrr = 1
        disable_hyprland_logo = true
        disable_splash_rendering = true
        mouse_move_enables_dpms = true
        # groupbar_gradients = false
      }

      #-- Animations -----------------------------------------------
      animations {
        enabled = true

        # bezier = overshot, 0.05, 0.9, 0.1, 1.05
        bezier = overshot, 0.7, 0.6, 0.1, 1.1
        bezier = smoothOut, 0.36, 0, 0.66, -0.56
        bezier = smoothIn, 0.25, 1, 0.5, 1
        bezier = bounce, 0.7, 1.6, 0.1, 0.85

        animation = windows, 1, 2, bounce, slide
        animation = windowsOut, 1, 3, bounce, slide
        animation = windowsMove, 1, 2, default
        animation = border, 1, 2, default
        animation = fade, 1, 2, smoothIn
        animation = fadeDim, 1, 2, smoothIn
        animation = workspaces, 1, 3, smoothIn, slide
        animation = specialWorkspace, 1, 3, overshot, slidevert
      }

      #-- General ----------------------------------------------------
      # General settings like MOD key, Gaps, Colors, etc.
      general {
        sensitivity = 1.5
      	apply_sens_to_raw = 0

        gaps_in = 2
        gaps_out = 2

        border_size = 3
        col.active_border = rgb(a7c080)
        col.inactive_border = rgb(475258)
        # col.group_border_active = rgb(e67e80)
        # col.group_border = rgb(7fbbb3)


        # damage_tracking=full 	# leave it on full unless you hate your GPU and want to make it suffer
      }

      cursor {
        inactive_timeout = 10
      }

      group {
        # col.border_active = rgb(e67e80)
        col.border_active = rgb(a7c080)
        col.border_inactive = rgb(7fbbb3)
        groupbar {
          gradients = false
          # col.active = rgb(e67e80)
          col.active = rgb(a7c080)
          col.inactive = rgb(7fbbb3)
          font_size = 0
          render_titles = false
        }
      }

      #-- Decoration ----------------------------------------------------
      # Decoration settings like Rounded Corners, Opacity, Blur, etc.
      decoration {
        rounding = 14
        # multisample_edges = 4

        active_opacity = 1
        inactive_opacity = 1
        fullscreen_opacity = 1

        blur {
          enabled = true
          size = 3 # minimum 1
          passes = 4 # minimum 1, more passes = more resource intensive.
          ignore_opacity = 0
          new_optimizations = true
        }

          # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
          # if you want heavy blur, you need to up the blur_passes.
          # the more passes, the more you can up the blur_size without noticing artifacts.

        shadow_range = 10
        shadow_render_power = 3
        col.shadow = 0x990F0F0F
        drop_shadow = false
      }

      #-- Dwindle ----------------------------------------------------
      dwindle {
        pseudotile = true			# enable pseudotiling on dwindle
        force_split = 2
        preserve_split = false
        no_gaps_when_only = true
        special_scale_factor = .9
      }

      #-- Master -----------------------------------------------------
      master {
          no_gaps_when_only = true
          # new_is_master = false
          # new_status=slave
      }

      #-- Plugins ----------------------------------------------------
      plugin {
          # hyprbars {
          #     # config
          # }
      }


      #-- Window Rules ------------------------------------------------
      windowrule = float,nm-connection-editor|pavucontrol
      windowrule = float,kvantummanager|qt5ct
      # windowrule = float,VirtualBox Manager|qemu|Qemu-system-x86_64
      windowrule = float,gnome-policykit-agent
      windowrule = float,blueman-manager
      windowrule = tile, title:^(SimpleX)


      windowrule = opacity .9 .8 ,kitty
      #make neovim less transparent that a regular terminal when focused
      windowrule = opacity 1.2 .9, title:^(nv)$

      windowrule = workspace 1, $term
      windowrule = workspace 2, $browser
      windowrule = workspace 3, $mail
      windowrule = workspace 6, flatpak run com.discordapp.Discord
      windowrule = workspace 7, valent

      windowrule = pin, title:^(Floating Window - Show Me The Key)(.*)$
      windowrule = float, title:^(Floating Window - Show Me The Key)(.*)$
      windowrule = pseudo, title:^(Floating Window - Show Me The Key)(.*)$

      exec-once = $XDG_CONFIG_HOME/hypr/scripts/cleanup.sh

      #-- Keybindings ----------------------------------------------------
      $term = kitty
      $menu = fuzzel
      $dashboard = $XDG_CONFIG_HOME/eww/dashboard/launch_dashboard.sh
      $volume = $XDG_CONFIG_HOME/hypr/scripts/volume.sh
      $backlight = $XDG_CONFIG_HOME/hypr/scripts/brightness.sh
      $screenshot = $XDG_CONFIG_HOME/hypr/scripts/screenshot.sh
      # $lockscreen = $XDG_CONFIG_HOME/hypr/scripts/lockscreen.sh
      $colorpicker = $XDG_CONFIG_HOME/hypr/scripts/colorpicker.sh
      $files = kitty yazi
      $editor = kitty nvim
      $browser = floorp
      $mail = kitty neomutt
      # $kilw = sh ~/.config/hypr/scripts/killw.sh
      # $revw=sh ~/.config/hypr/scripts/statusbar
      $music = $term ncmpcpp
      $bluemenu = $XDG_CONFIG_HOME/hypr/scripts/fuzzel_blue.sh
      $logoutmenu = wlogout
      $powermenu = $XDG_CONFIG_HOME/hypr/scripts/powerprofile.sh
      $wifimenu = networkmanager_dmenu
      $task = kitty taskwarrior-tui

      # -- Layouts --
      bind = ALT, L, exec, hyprctl keyword general:layout dwindle
      bind = ALT, M, exec, hyprctl keyword general:layout master

      # -- Terminal --
      bind = SUPER, Return, exec, $term
      # bind = SUPER, T, exec, $term

      # -- Apps --
      bind = SUPER, F, exec, $files
      bind = SUPER, V, exec, $editor
      bind = SUPER, E, exec, $mail
      bind = SUPER, W, exec, $browser
      bind = SUPER, M, exec, $music
      bind = SUPER, T, exec, $task
      bind = SUPER, A, exec, swaync-client -t

      # -- Menus --
      bind = ALT, F1, exec, $menu
      bind = SUPER, D, exec, $dashboard
      bind = CTRL, SPACE, exec, $menu
      # bind = SUPERSHIFT, D, exec, $dashboard
      bind = SUPER, B, exec, $bluemenu
      bind = SUPERSHIFT, X, exec, $logoutmenu
      bind = SUPERSHIFT, w, exec, $wifimenu
      bind = SUPERSHIFT, P, exec, $powermenu

      # -- Clipman --
      bind = SUPER, C, exec, clipman pick --tool=CUSTOM --tool-args="fuzzel --dmenu --lines 14 --prompt \" \" "

      # -- Misc --
      bind = SUPER, P, exec, $colorpicker
      # bind = SUPERSHIFT, L, exec, $lockscreen
      # bind = SUPER, O, exec, sh ~/.config/hypr/scripts/killw.sh
      bind=SUPERSHIFT,V,exec,~/.config/hypr/scripts/pia-client-start.sh

      # -- Function keys --
      bind = , XF86MonBrightnessUp, exec, $backlight --inc
      bind = , XF86MonBrightnessDown, exec, $backlight --dec
      bind = , XF86AudioRaiseVolume, exec, $volume --inc
      bind = , XF86AudioLowerVolume, exec, $volume --dec
      bind = , XF86AudioMute, exec, $volume --toggle
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioStop, exec, playerctl pause

      # -- Laptop switch --
      # trigger when the switch is turning off
      bindl = , switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 2256x1504@60,0x0, 1.175"
      # monitor = # trigger when the switch is turning on
      bindl = , switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"

      # -- Screenshots --
      bind = , Print, exec, $screenshot --now
      bind = SUPER, Print, exec, $screenshot --in5
      bind = SHIFT, Print, exec, $screenshot --in10
      bind = CTRL, Print, exec, $screenshot --win
      bind = SUPERCTRL, Print, exec, $screenshot --area

      # -- Hyprland --
      bind = SUPERSHIFT, q, killactive,
      #bind = CTRLALT, Delete, exit,
      bind = SUPERSHIFT, f, fullscreen,
      bind = SUPER, Space, togglefloating,
      bind = SUPER, S, pseudo,
      bind = SUPER, X, exec, hyprctl dispatch togglegroup none
      bind = SUPER, n, exec, hyprctl dispatch changegroupactive f
      bind = ALT, up, exec, hyprctl dispatch moveintogroup u
      bind = ALT, down, exec, hyprctl dispatch moveintogroup d
      bind = ALT, left, exec, hyprctl dispatch moveintogroup l
      bind = ALT, right, exec, hyprctl dispatch moveintogroup r
      bind = ALT, x, exec, hyprctl dispatch moveoutofgroup

      #Focus
      bind = SUPER, h, movefocus, l
      bind = SUPER, l, movefocus, r
      bind = SUPER, k, movefocus, u
      bind = SUPER, j, movefocus, d

      # Move
      bind = SUPERSHIFT, h, movewindow, l
      bind = SUPERSHIFT, l, movewindow, r
      bind = SUPERSHIFT, k, movewindow, u
      bind = SUPERSHIFT, j, movewindow, d

      bindm=SUPER,mouse:272,movewindow

      # Resize
      bind = SUPER, left, resizeactive, -100 0
      bind = SUPER, right, resizeactive, 100 0
      bind = SUPER, up, resizeactive, 0 -100
      bind = SUPER, down, resizeactive, 0 100

      bindm = SUPER, mouse:273, resizewindow

      # Workspaces
      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10

      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1

      # Send to Workspaces
      bind = SUPERSHIFT, 1, movetoworkspace, 1
      bind = SUPERSHIFT, 2, movetoworkspace, 2
      bind = SUPERSHIFT, 3, movetoworkspace, 3
      bind = SUPERSHIFT, 4, movetoworkspace, 4
      bind = SUPERSHIFT, 5, movetoworkspace, 5
      bind = SUPERSHIFT, 6, movetoworkspace, 6
      bind = SUPERSHIFT, 7, movetoworkspace, 7
      bind = SUPERSHIFT, 8, movetoworkspace, 8
      bind = SUPERSHIFT, 9, movetoworkspace, 9
      bind = SUPERSHIFT, 0, movetoworkspace, 10

      #Scratchpad
      bind = SUPER, z, togglespecialworkspace
      bind = SUPERSHIFT, Z, movetoworkspace, special

      #Plugins
      # bind = SUPERSHIFT, R, hyprload,reload
      # bind = SUPERSHIFT, U, hyprload,update

      #-- Move workspaces on connect ---------------------------------
      exec-once=$XDG_CONFIG_HOME/hypr/scripts/handle-monitor-connect.sh

      #-- Cursors ----------------------------------------------------
      exec-once = hyprctl setcursor Bibata-Modern-Classic 18
      # exec-once = seat seat0 xcursor_theme Bibata-Modern-Classic 18

      #-- Graphical session target ----------------------------------
      exec-once = systemctl --user start graphical-session.target

      #-- Polkit  ----------------------------------------------------
      # exec-once=/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

      #-- Plugins ----------------------------------------------------
      # exec-once=$HOME/.local/share/hyprload/hyprload.sh

      #-- Startup ----------------------------------------------------
      # Start up script
      exec-once=sh $XDG_CONFIG_HOME/hypr/scripts/startup

    '';
  };

  # services = {
  #   swaync.enable = true;
  # };
}
