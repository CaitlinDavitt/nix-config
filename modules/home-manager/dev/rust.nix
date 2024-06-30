{ pkgs-unstable, fenix, ... }: 
{
  nixpkgs.overlays = [ fenix.overlays.default ];
  environment.systemPackages = with pkgs-unstable; [
  (fenix.complete.withComponents [
    "cargo"
    "clippy"
    "rust-src"
    "rustc"
    "rustfmt"
    ])
  rust-analyzer
  clippy
  cargo-flamegraph
  ];
}
