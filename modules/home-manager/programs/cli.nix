# Cli programs for productivity in the terminal
{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    yazi
    xdragon
  ];
}
