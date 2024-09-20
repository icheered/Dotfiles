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
in
{
  imports = moduleImports ++ appimageImports;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Window managers and desktop environments
    i3
    i3lock-fancy-rapid
    picom # A compositor that allows transparent windows
    gnome.gnome-keyring
    gnome.gnome-tweaks
    gnome.dconf-editor
    polybarFull
    fuse # Filesystem in Userspace, includes often-needed dependencies
    glib # Includes often-needed dependencies
    variety
    feh

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
    tree
    appimage-run # For running AppImages and other applications!
    pulseaudio
    direnv # Automatically load environment variables in directory
    playerctl # Media control
    ncdu # Indexes the file system disk usage, very useful if system gets full

    # Development tools
    git
    jdk21_headless # Java Development Kit
    python3
    nodejs_22
    nodePackages.yarn
    prisma-engines

    # Text editors and IDEs
    vim
    vscode
    nixfmt-rfc-style # Formatter for nix files
    xfce.mousepad

    # Web browsers
    firefox
    google-chrome

    # Personal
    ferdium
    spotify
    steam
    modrinth-app # Minecraft launcher
    davinci-resolve
    obsidian
  ];

  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackages programs here
    zlib # Provides 'libz.so.1'
  ];

  # Any other configurations that don't fit into specific modules
  # or that you want to keep in the main file can go here
  system.stateVersion = "24.05";
}
