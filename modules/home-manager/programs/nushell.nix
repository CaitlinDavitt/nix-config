{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.nushell = {
    enable = true;
    extraEnv = ''
      mkdir ~/.cache/starship
      starship init nu | save -f ~/.cache/starship/init.nu

    '';

    extraConfig = ''
      use ~/.cache/starship/init.nu
      $env.config = {
        show_banner: false,
      }

      alias nixrs = sudo nixos-rebuild --flake ~/.config/nix-config/.#nixos switch
    '';
  };
}
