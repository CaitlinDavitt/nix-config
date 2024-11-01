# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Hyprland
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    # ./swaylock.nix
    ./hyprlock.nix
    # ./hyprlock.nix
    # ./swayidle.nix
    ./hypridle.nix
    ./wlogout.nix
    ./fuzzel.nix
  ];
}
