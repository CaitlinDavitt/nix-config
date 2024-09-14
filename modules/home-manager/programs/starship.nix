{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 1000;
      palette = "everforest";
      format = "[](fg:blue)[ ](bg:blue fg:bg0)[](fg:blue bg:green)$directory[](fg:green bg:yellow)$git_branch$git_status$git_metrics[](fg:yellow bg:bg0)$nix_shell$rust$c$java$python$fill[](fg:purple)$cmd_duration$time[](fg:purple)\n$character";

      palettes.everforest = {
        bg0 = "#2d353b";
        bg1 = "#2d353b";
        bg2 = "#3d484d";
        bg3 = "#475258";
        blue = "#7fbbb3";
        green = "#a7c080";
        yellow = "#dbbc7f";
        orange = "#e69875";
        purple = "#d699b6";
        red = "#e67e80";
        aqua = "#83c092";
        text = "#d3c6aa";
      };

      fill = {
        symbol = "_";
        style = "bg3";
      };

      directory = {
        format = "[  $path ]($style)";
        style = "fg:bg0 bg:green";
        truncation_symbol = ".../";
        truncation_length = 3;
        truncate_to_repo = false;
      };

      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style)";
        symbol = " 󰘬 ";
        style = "fg:bg0 bg:yellow";
      };

      git_status = {
        format = "[$all_status]($style)";
        style = "fg:bg0 bg:yellow";
      };

      git_metrics = {
        format = "[+$added]($added_style)[-$deleted]($deleted_style)";
        added_style = "fg:bg0 bg:yellow";
        deleted_style = "fg:bg0 bg:yellow";
        disabled = false;
      };

      hg_branch = {
        format = "[$symbol$branch]($style)";
        symbol = " ";
      };

      character = {
        success_symbol = "[  ](bold green)";
        error_symbol = "[  ](bold red)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:purple";
        format = "[[󱑍 $time](bg:purple fg:bg0)]($style)";
      };

      cmd_duration = {
        style = "bg:purple fg:bg0";
        format = "[took $duration ]($style)";
      };

      custom.live-clock-icon = {
        command = "echo \"\" | cut -c $(($(date +%H)%12+1))";
        description = "Live updating clock icon, changes hourly. Icons can be customized to your liking.";
        when = true;
        style = "fg:bg0 bg:aqua";
        format = "[$output ]($style)";
      };

      # nix-shell = {
      # format = " via [$symbol($version )]($style)";
      # symbol = "❄️";
      # style = "bold blue";
      # disabled = true;
      # };

      rust = {
        format = " via [$symbol($version )]($style)";
        style = "bold red";
      };

      c = {
        format = " via [$symbol($version )]($style)";
        style = "bold blue";
      };

      java = {
        format = " via [$symbol($version )]($style)";
        style = "bold orange";
      };

      python = {
        format = " via [$symbol($version )]($style)";
        style = "bold yellow";
      };
    };
  };
}
