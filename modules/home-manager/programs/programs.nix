{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    bat
    yazi
    blanket
    cowsay
    cbonsai
    parallel
    ttyper
    # helix
    tmux
    zellij
    lldb
    mpd-notification

    # jdk17
    gnumake
    taskwarrior
    taskwarrior-tui
    # Gnome icons for gtklock
    gnome.adwaita-icon-theme
    papirus-icon-theme
    gnome-feeds
    # xdg-desktop-portal-gtk
    #xsettingsd
    #glib
    #gsettings-desktop-schemas
    # xdg-desktop-portal-wlr
    sass

    evince
    baobab

    openvpn

    appimage-run

    # docker
    virt-viewer

    qt5.qtwayland
    qt6.qtwayland
    wdisplays
    # sunshine

    tuba

    popsicle

    # heroic
    # webcord-vencord

    nodePackages.bash-language-server
    nodejs

    celluloid
    foliate
    fragments
    # mpv

    typst-lsp

    floorp
    openjdk17

    shotcut

    pywal
  ];
}
