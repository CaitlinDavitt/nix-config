{
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Programs
    # ./gtklock.nix
    ./nonfree.nix
    ./programs.nix
    ./programs-unstable.nix
    ./helix.nix
    ./cli.nix
    ./starship.nix
    ./nushell.nix
  ];
}
