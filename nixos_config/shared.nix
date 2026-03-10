{ config, pkgs, ... }:

let
  # Function to import all .nix files in a directory
  importDir =
    dir:
    map (f: dir + "/${f}") (
      builtins.filter (f: builtins.match ".*\\.nix" f != null) (builtins.attrNames (builtins.readDir dir))
    );

  # Import all .nix files from modules directory
  moduleImports = importDir ./modules;

  # Import all .nix files from appimages directory
  # Use these for any appimages that you want to be part of the nixos configuration
  # Any single-use appimages or binaries can be run directly and don't have to be declared
  appimageImports = importDir ./appimages;

  # Allow unstable packages
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };

in
{
  imports = moduleImports ++ appimageImports;
  programs.steam.enable = true;

  programs.nix-ld.enable = true;
  #programs.nix-ld.package = pkgs.nix-ld-rs;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Window managers and desktop environments
    i3
    i3lock-fancy-rapid
    picom # A compositor that allows transparent windows
    gnome-keyring
    gnome-tweaks
    dconf-editor
    polybarFull
    fuse # Filesystem in Userspace, includes often-needed dependencies
    glib # Includes often-needed dependencies
    variety
    feh
    #libicu-dev # for smapi stardew valley

    # Terminal and shell
    kitty
    zsh
    zoxide
    starship

    # System utilities
    openssl
    wget
    usbutils
    rofi
    espanso
    xbindkeys
    flameshot
    clipit
    numlockx
    htop
    #nvtopPackages.full
    tree
    appimage-run # For running AppImages and other applications!
    pulseaudio
    direnv # Automatically load environment variables in directory
    playerctl # Media control
    ncdu # Indexes the file system disk usage, very useful if system gets full
    rm-improved # A better 'rm', adds the 'rip' command
    lsof # Allows scanning for currently open ports
    speedtest-cli
    vlc
    ffmpeg
    redshift # Make screen orange
    geoclue2
    killall
    traceroute
    rpi-imager
    xdotool
    bc # Commandline calculator
    xclip
    eza # Modern replacement of 'ls' command
    unzip
    nixpkgs-fmt
    arandr
    ddrescue
    lazygit
    pulsemixer
    lsdvd
    xfce.thunar
    xfce.xfconf

    # Development tools
    git
    jdk21_headless # Java Development Kit
    poetry
    unstable.uv
    zstd # needed as dependency for pytorch
    zstd.dev
    (zstd.override { enableStatic = false; })
    heroku
    gcc
    stdenv.cc.cc.lib
    zlib
    python311Packages.xlib # X11 interface library
    python314
    #nodejs_18
    nodejs_20
    julia
    ghc # haskell
    esptool
    nmap
    yarn
    smartmontools # Monitor HDD health
    pm2 # Deploy multiple node applications
    docker-compose
    android-tools
    zig
    blender

    # A bunch of stuff to get prisma to work...
    #nodePackages.yarn
    #nodePackages_latest.pnpm
    #nodePackages_latest.vercel
    #nodePackages_latest.prisma
    #openssl
    #nodejs_22

    # Text editors and IDEs
    vim
    vscode
    nixfmt-rfc-style # Formatter for nix files
    xfce.mousepad
    neovim
    tmux
    code-cursor

    # Web browsers
    firefox
    google-chrome

    # Personal
    unstable.ferdium
    spotify
    steam
    modrinth-app # Minecraft launcher
    prismlauncher
    #davinci-resolve
    obsidian
    bambu-studio
    orca-slicer
    openscad
    popcorntime
    qbittorrent
    workrave
    signal-desktop
    tailscale
    xclicker

    # # Trying to get python to work
    # glib
    # zlib
    # libGL
    # fontconfig
    # xorg.libX11
    # libxkbcommon
    # freetype
    # dbus
    # python312Packages.pyqt5
    # python312Packages.pyqt6
    # python312Packages.tkinter
  ];

  programs.nix-ld.libraries = with pkgs; [
    # Add common runtime dependencies here
    stdenv.cc.cc
    zlib
    glib
    openssl
    xorg.libXft
    zstd
  ];
  environment.variables = {
    ld_library_path = "${
      pkgs.lib.makeLibraryPath [
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
        pkgs.zstd
      ]
    }:${pkgs.zstd}/lib:$LD_LIBRARY_PATH";
  };

  # Any other configurations that don't fit into specific modules
  # or that you want to keep in the main file can go here
  system.stateVersion = "24.05";
}
