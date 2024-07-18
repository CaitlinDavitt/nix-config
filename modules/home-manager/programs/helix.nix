{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      # theme = "everforest-dark";
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        line-number = "relative";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        language-servers = ["nil"];
      }
      {
        name = "rust";
        auto-format = true;
      }
    ];
  };
}
