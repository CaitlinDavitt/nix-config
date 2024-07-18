{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    hpyrlock
  ];
}
