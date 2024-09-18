{ config, pkgs, ... }:

let
  # Function to import all .nix files in a directory
  importDir = dir: map (f: dir + "/${f}") (
    builtins.filter (f: builtins.match ".*\\.nix" f != null) 
      (builtins.attrNames (builtins.readDir dir))
  );

  # Import all .nix files from modules directory
  moduleImports = importDir ./modules;

  # Import all .nix files from appimages directory
  appimageImports = importDir ./appimages;
in
{
  imports = moduleImports ++ appimageImports;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    firefox
    git
    i3
    gnome.gnome-tweaks
    gnome.dconf-editor
    polybar
    zsh
    zoxide
    starship
    rofi
    kitty
    ferdium
    xfce.mousepad
    google-chrome
    espanso
    xbindkeys
    flameshot
    clipit
    numlockx
    spotify
    vscode
    tree
    modrinth-app
    steam
    appimage-run
    obsidian
  ];

  # Any other configurations that don't fit into specific modules
  # or that you want to keep in the main file can go here
  system.stateVersion = "24.05";
}
