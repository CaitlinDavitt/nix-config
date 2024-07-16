{
  pkgs,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # (fenix.complete.withComponents [
    #   "cargo"
    #   "clippy"
    #   "rust-src"
    #   "rustc"
    #   "rustfmt"
    # ])
    cargo
    clippy
    rustc
    rustfmt
    rust-analyzer
    clippy
    cargo-flamegraph
  ];
}
