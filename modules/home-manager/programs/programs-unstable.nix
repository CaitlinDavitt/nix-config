{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    # hyprland
    eww
    # steam
    # steam-tui
    # steamcmd
    # steam-cli
    # xdg-desktop-portal-hyprland
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-gnome
    # xdg-desktop-portal-wlr
    swww
    ironbar
    eza
    lxd-lts
    typst
    typstfmt
    # typst-lsp
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.plasma-workspace
    libsForQt5.plasma-integration

    libsForQt5.qtstyleplugins
    qt6Packages.qtstyleplugin-kvantum
    distrobox
    #(waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true "]; }))
    # bun
    libreoffice-fresh
    simplex-chat-desktop
    discord-screenaudio

    # mediawriter

    cosmic-term

    # waybar
    xwaylandvideobridge
    mpd-notification

    # thunderbird
    pywalfox-native
    pywal16
  ];
}
