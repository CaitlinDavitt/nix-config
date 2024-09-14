{
  pkgs,
  config,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
        ignore_empty_input = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(211, 198, 170)";
          inner_color = "rgb(52, 63, 68)";
          outer_color = "rgb(167, 192, 128)";
          check_color = "rgb(127, 187, 179)";
          fail_col0r = "rgb(230, 126, 128)";
          capslock_color = "rgb(230, 152, 117)";
          numlock_color = "rgb(230, 152, 117)";
          outline_thickness = 5;
          placeholder_text = "<span font_family='GeistMono Nerd Font'> Input Password... </span>";
          fail_text = "<span font_family='GeistMono Nerd Font'> <i>$FAIL <b>($ATTEMPTS)</b></i></span>";
          # placeholder_text = "";
          shadow_passes = 2;
          font_family = "FiraCode Nerd Font";
          font_size = 12;
        }
      ];

      label = [
        {
          font_family = "FiraCode Nerd Font";
          text = "Welcome Back Caitlin!";
          # text = "󰊠  ";
          text_align = "center";
          color = "rgb(211, 198, 170)";
          font_size = 35;
          position = "0, +50";
          halign = "center";
          valign = "center";
        }
        {
          font_family = "FiraCode Nerd Font";
          # text = "Hello there, $USER";
          text = "cmd[update:1] echo \"$(date +%T)\"";
          text_align = "center";
          color = "rgb(211, 198, 170)";
          font_size = 50;
          position = "0, +100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
