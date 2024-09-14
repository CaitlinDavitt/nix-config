# This nis your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  gBar,
  # fenix,
  # nixpkgs-unstable,
  # pkgs.unstable,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    # extraSpecialArgs = {inherit inputs gBar fenix outputs nixpkgs-unstable;};
    extraSpecialArgs = {inherit inputs gBar outputs;};
    # extraSpecialArgs = { inherit inputs gBar pkgs-unstable fenix outputs; };
    users = {
      # Import your home-manager configuration
      caitlin = import ../home-manager/home.nix;
    };
    backupFileExtension = "bak-";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };

    settings.auto-optimise-store = true;

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # FIXME: Add the rest of your current configuration

  networking.hostName = "nixos";

  # # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  # users.users = {
  #   # FIXME: Replace with your username
  #   your-username = {
  #     # TODO: You can set an initial password for your user.
  #     # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
  #     # Be sure to change it (using passwd) after rebooting!
  #     initialPassword = "correcthorsebatterystaple";
  #     isNormalUser = true;
  #     # openssh.authorizedKeys.keys = [
  #     #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
  #     # ];
  #     # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
  #     extraGroups = ["wheel"];
  #   };
  # };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     # Opinionated: forbid root login through SSH.
  #     PermitRootLogin = "no";
  #     # Opinionated: use keys only.
  #     # Remove if you want to SSH using passwords
  #     PasswordAuthentication = false;
  #   };
  # };

  users.users.caitlin = {
    isNormalUser = true;
    description = "caitlin";
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel" "video" "libvirtd" "docker" "lxd"];
    # extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "lxd"];
    packages = with pkgs; [
      # firefox
      #brave
      neovim
      cinnamon.nemo
      gvfs
      procps
      psmisc
      git
      gh
      gcc
      wget
      lazygit
      fish
      kitty
      btop
      thefuck
      tealdeer
      ripgrep
      autojump
      zoxide
      fzf
      man
      deja-dup
      betterdiscordctl
      # element-desktop
      blanket
      bat
      # eww-wayland
      cava
      polkit_gnome
      polkit
      gnome.gnome-keyring
      clipman
      wl-clipboard
      networkmanagerapplet
      networkmanager-vpnc
      networkmanager-openvpn
      imagemagick
      slurp
      grim
      # swayidle
      wlsunset
      # xdg-desktop-portal-hyprland
      # xdg-desktop-portal-gtk
      #xdg-desktop-portal-wlr
      xdg-user-dirs
      # eww
      dash
      pavucontrol
      mpd
      mpc-cli
      playerctl
      ffmpeg
      ncmpcpp
      pfetch
      libnotify
      mako
      material-icons
      material-design-icons
      papirus-icon-theme
      jq
      jaq
      socat
      gimp
      neofetch
      unzip
      light
      blueman
      bc
      jc
      pkg-config
      keychain
      # bitwarden
      cmatrix
      gthumb
      upower
      power-profiles-daemon
      powertop
      parted
      xorg.xhost
      xdg-utils
      # xdg-desktop-portal-wlr

      gnome-online-accounts
      gnome.gnome-control-center
      gnutls
      # gnome.geary
      gnome.gnome-calendar

      # thunderbird
      # pantheon.elementary-mail
    ];
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "Noto" "Meslo" "SpaceMono" "NerdFontsSymbolsOnly" "GeistMono"];})
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      dejavu_fonts
      corefonts
      liberation_ttf
      font-awesome
      roboto
      ubuntu_font_family
      meslo-lgs-nf
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Liberation Serif"];
        sansSerif = ["Ubuntu"];
        monospace = ["FiraCode Nerd Font"];
      };
    };
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_PICTURES_DIR = "$HOME/Pictures/";
    #XCURSOR_PATH = "/usr/share/icons:$XDG_DATA_HOME/icons";
    EDITOR = "nvim";
    TERM = "kitty";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_STYLE_OVERRIDE = "kvantum";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "18";
  };

  environment.systemPackages = [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    # pkgs.python3.withPackages
    # (ps:
    #   with ps; [
    #     pip
    #     imaplib2
    #     matplotlib
    #     pandas
    #     numpy
    #   ])
    pkgs.greetd.tuigreet
    pkgs.virt-manager
    pkgs.qemu
    pkgs.dash
    pkgs.exfatprogs
    pkgs.qt6.qtwayland
    pkgs.sqlite
    inputs.zen-browser.packages."x86_64-linux".default
    # pkgs.wayfire
    # linux-firmware
  ];

  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = ["network.target" "sound.target"];
      wantedBy = ["default.target"];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };

  services.udev.extraRules = ''
        # Your rule goes here
        # udev rule to detect android devices
    # These rules refer to http://developer.android.com/tools/device.html

    # Acer
    SUBSYSTEM=="usb", ATTR{idVendor}=="0502", MODE="0666", GROUP="plugdev"
    # Archos
    SUBSYSTEM=="usb", ATTR{idVendor}=="0e79", MODE="0666", GROUP="plugdev"
    # Asus
    SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", MODE="0666", GROUP="plugdev"
    # Azpen Onda
    SUBSYSTEM=="usb", ATTR{idVendor}=="1f3a", MODE="0666", GROUP="plugdev"
    # BQ
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a47", MODE="0666", GROUP="plugdev"
    # Dell
    SUBSYSTEM=="usb", ATTR{idVendor}=="413c", MODE="0666", GROUP="plugdev"
    # Fairphone
    SUBSYSTEM=="usb", ATTR{idVendor}=="2ae5", MODE="0666", GROUP="plugdev"
    # Foxconn
    SUBSYSTEM=="usb", ATTR{idVendor}=="0489", MODE="0666", GROUP="plugdev"
    # Fujitsu Toshiba
    SUBSYSTEM=="usb", ATTR{idVendor}=="04c5", MODE="0666", GROUP="plugdev"
    # Garmin-Asus
    SUBSYSTEM=="usb", ATTR{idVendor}=="091e", MODE="0666", GROUP="plugdev"
    # Google
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
    # Haier
    SUBSYSTEM=="usb", ATTR{idVendor}=="201e", MODE="0666", GROUP="plugdev"
    # Hisense
    SUBSYSTEM=="usb", ATTR{idVendor}=="109b", MODE="0666", GROUP="plugdev"
    # HTC, Wiko
    SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", MODE="0666", GROUP="plugdev"
    # Huawei
    SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", MODE="0666", GROUP="plugdev"
    # Intel
    SUBSYSTEM=="usb", ATTR{idVendor}=="8087", MODE="0666", GROUP="plugdev"
    # K-Touch
    SUBSYSTEM=="usb", ATTR{idVendor}=="24e3", MODE="0666", GROUP="plugdev"
    # KT Tech
    SUBSYSTEM=="usb", ATTR{idVendor}=="2116", MODE="0666", GROUP="plugdev"
    # Kyocera
    SUBSYSTEM=="usb", ATTR{idVendor}=="0482", MODE="0666", GROUP="plugdev"
    # Lab126
    SUBSYSTEM=="usb", ATTR{idVendor}=="1949", MODE="0666", GROUP="plugdev"
    # Lenovo
    SUBSYSTEM=="usb", ATTR{idVendor}=="17ef", MODE="0666", GROUP="plugdev"
    # LG
    SUBSYSTEM=="usb", ATTR{idVendor}=="1004", MODE="0666", GROUP="plugdev"
    # Meizu
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a45", MODE="0666", GROUP="plugdev"
    # Micromax
    SUBSYSTEM=="usb", ATTR{idVendor}=="1ebf", MODE="0666", GROUP="plugdev"
    # Motorola
    SUBSYSTEM=="usb", ATTR{idVendor}=="22b8", MODE="0666", GROUP="plugdev"
    # MTK
    SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", MODE="0666", GROUP="plugdev"
    # NEC
    SUBSYSTEM=="usb", ATTR{idVendor}=="0409", MODE="0666", GROUP="plugdev"
    # Nook
    SUBSYSTEM=="usb", ATTR{idVendor}=="2080", MODE="0666", GROUP="plugdev"
    # Nvidia
    SUBSYSTEM=="usb", ATTR{idVendor}=="0955", MODE="0666", GROUP="plugdev"
    # OnePlus Two (unknown vendor's name)
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a70", MODE="0666", GROUP="plugdev"
    # Oppo
    SUBSYSTEM=="usb", ATTR{idVendor}=="22d9", MODE="0666", GROUP="plugdev"
    # OTGV
    SUBSYSTEM=="usb", ATTR{idVendor}=="2257", MODE="0666", GROUP="plugdev"
    # Pantech
    SUBSYSTEM=="usb", ATTR{idVendor}=="10a9", MODE="0666", GROUP="plugdev"
    # Pegatron
    SUBSYSTEM=="usb", ATTR{idVendor}=="1d4d", MODE="0666", GROUP="plugdev"
    # Philips
    SUBSYSTEM=="usb", ATTR{idVendor}=="0471", MODE="0666", GROUP="plugdev"
    # PMC-Sierra
    SUBSYSTEM=="usb", ATTR{idVendor}=="04da", MODE="0666", GROUP="plugdev"
    # Qualcomm
    SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev"
    # Rockcwell Electronics
    SUBSYSTEM=="usb", ATTR{idVendor}=="2207", MODE="0666", GROUP="plugdev"
    # SK Telesys
    SUBSYSTEM=="usb", ATTR{idVendor}=="1f53", MODE="0666", GROUP="plugdev"
    # Samsung
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
    # Sharp
    SUBSYSTEM=="usb", ATTR{idVendor}=="04dd", MODE="0666", GROUP="plugdev"
    # Sony
    SUBSYSTEM=="usb", ATTR{idVendor}=="054c", MODE="0666", GROUP="plugdev"
    # Sony Ericsson
    SUBSYSTEM=="usb", ATTR{idVendor}=="0fce", MODE="0666", GROUP="plugdev"
    # Spreadtrum
    SUBSYSTEM=="usb", ATTR{idVendor}=="1782", MODE="0666", GROUP="plugdev"
    # T & A Mobile Phones
    SUBSYSTEM=="usb", ATTR{idVendor}=="1bbb", MODE="0666", GROUP="plugdev"
    # Teleepoch
    SUBSYSTEM=="usb", ATTR{idVendor}=="2340", MODE="0666", GROUP="plugdev"
    # Texas Instruments UsbBoot
    SUBSYSTEM=="usb", ATTR{idVendor}=="0451", MODE="0666", GROUP="plugdev"
    # Toshiba
    SUBSYSTEM=="usb", ATTR{idVendor}=="0930", MODE="0666", GROUP="plugdev"
    # Wearners
    SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev"
    # Wileyfox
    SUBSYSTEM=="usb", ATTR{idVendor}=="2970", MODE="0666", GROUP="plugdev"
    # XiaoMi
    SUBSYSTEM=="usb", ATTR{idVendor}=="2717", MODE="0666", GROUP="plugdev"
    # YU
    SUBSYSTEM=="usb", ATTR{idVendor}=="1ebf", MODE="0666", GROUP="plugdev"
    # Zebra
    SUBSYSTEM=="usb", ATTR{idVendor}=="05e0", MODE="0666", GROUP="plugdev"
    # ZTE
    SUBSYSTEM=="usb", ATTR{idVendor}=="19d2", MODE="0666", GROUP="plugdev"
    # ZUK
    SUBSYSTEM=="usb", ATTR{idVendor}=="2b4c", MODE="0666", GROUP="plugdev"
  '';

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    image = "/home/caitlin/Downloads/waneella/Dark_Corners_waneella.webp";

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 18;
    };
  };

  services.auto-cpufreq.enable = false;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  powerManagement.powertop.enable = true;

  users.extraGroups.vboxusers.members = ["caitlin"];
  programs.dconf.enable = true;

  environment.etc."vbox/networks.conf".text = ''
    * 192.168.0.0/16
  '';

  virtualisation = {
    libvirtd.enable = true;
    # docker.enable = true;
    # docker.storageDriver = "btrfs";
    # virtualbox.host.enable = true;
    # lxd.enable = true;
  };

  programs.fish.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  programs.light.enable = true;
  programs.gnome-disks.enable = true;
  services.udisks2.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "/home/caitlin/Music/";
    extraConfig = ''
      # must specify one or more outputs in order to play audio!
      # (e.g. ALSA, PulseAudio, PipeWire), see next sections
      audio_output {
      type "pipewire"
      name "My PipeWire Output"
      }

      audio_output {
      type "pipewire"
      name "My PipeWire Output"
      }
    '';

    # services.mpd-mpris.enable = true;

    # Optional:
    network.listenAddress = "6600"; # if you want to allow non-localhost connections
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  services = {
    blueman.enable = true;
    upower.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    atd.enable = true;
  };

  networking.firewall.enable = false;
  # networking.nameservers = ["194.242.2.4" "1.1.1.1" "8.8.8.8"];
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.printing.enable = true;
  console.keyMap = "us";

  security.pam.services.swaylock = {};
  security.pam.services.gtklock = {};
  security.pam.services.hyprlock = {};
  services.fprintd.enable = true;
  # services.accounts-daemon.enable = true;
  # services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.evolution-data-server.enable = true;
  # programs.waybar = {
  #   enable = true;
  # };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    package = pkgs.hyprland;
    # package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.hyprland;
  };

  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  #   package = pkgs.hyprland;
  # };
  # programs.hyprland = {
  #   enable = true;
  #   # set the flake package
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   # make sure to also set the portal package, so that they are in sync
  #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  # };
  #  services.fwupd.enable = true;
  services.chrony.enable = true;

  environment.binsh = "${pkgs.dash}/bin/dash";

  hardware = {
    opengl.enable = true;
    bluetooth.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "us";
    #displayManager.gdm = {
    #    enable = false;
    #    wayland = true;
    #};
  };

  services.xserver.enable = false;

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  time.timeZone = "America/Chicago";

  networking.networkmanager.enable = true;

  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      HandlePowerKeyLongPress=poweroff
      HandleLidSwitch=ignore
      HandleLidSwitchExternalPower=ignore
      HandleLidSwitchDocked=ignore
      HoldoffTimeoutSec=5s
    '';
  };
  systemd = {
    sleep.extraConfig = "HibernateDelaySec=1h";
  };

  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  boot.kernelModules = [
    # Virtual Camera
    "v4l2loopback"
    # Virtual Microphone, built-in
    "snd-aloop"
    # "perf"
  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.configurationLimit = 10;
  # hardware.framework.amd-7040.preventWakeOnAC = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
