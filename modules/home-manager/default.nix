# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Programming Languages
    ./dev/rust.nix
    ./dev/python.nix

    # Programs
    ./programs/gtklock.nix
    ./programs/nonfree.nix
    ./programs/programs.nix
    # ./programs/sunshine.nix
    ./programs/programs-unstable.nix
    ./programs/helix.nix
    ./programs/cli.nix
    ./programs/hyprland.nix
  ];
}
