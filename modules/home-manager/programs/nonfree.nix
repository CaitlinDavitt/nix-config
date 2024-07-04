{
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    discord
  ];
}
