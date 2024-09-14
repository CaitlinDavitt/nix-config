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
    ./programs/default.nix

    # ./programs/sunshine.nix
    ./hyprland/default.nix
  ];
}
