{pkgs, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    nil
    alejandra
  ];
}
