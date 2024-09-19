{ config, pkgs, ... }:

let
  # Function to import all .nix files in a directory
  importDir = dir:
    map (f: dir + "/${f}")
    (builtins.filter (f: builtins.match ".*\\.nix" f != null)
      (builtins.attrNames (builtins.readDir dir)));

  # Import all .nix files from modules directory
  moduleImports = importDir ./modules;

  # Import all .nix files from appimages directory
  # Use these for any appimages that you want to be part of the nixos configuration
  # Any single-use appimages or binaries can be run directly and don't have to be declared
  appimageImports = importDir ./appimages;
in {
  imports = moduleImports ++ appimageImports;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Window managers and desktop environments
    i3
    gnome.gnome-keyring
    gnome.gnome-tweaks
    gnome.dconf-editor
    polybar

    # Terminal and shell
    kitty
    zsh
    zoxide
    starship

    # System utilities
    rofi
    espanso
    xbindkeys
    flameshot
    clipit
    numlockx
    htop
    tree
    appimage-run # For running AppImages

    # Development tools
    git
    jdk21_headless # Java Development Kit
    python3
    nodejs_22
    nodePackages.yarn

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
  ];

  programs.nix-ld.libraries = with pkgs;
    [
      # Add any missing dynamic libraries for unpackages programs here
      zlib # Provides 'libz.so.1'
    ];

  # Any other configurations that don't fit into specific modules
  # or that you want to keep in the main file can go here
  system.stateVersion = "24.05";
}
