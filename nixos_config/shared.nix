# shared.nix
{ config, pkgs, ... }:

{
  imports = [
    ./modules/base.nix
    ./modules/i3.nix
    ./modules/dotfiles.nix
    ./modules/zsh.nix
    ./modules/services.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # This is placed here for easy access and frequent modifications
  environment.systemPackages = with pkgs; [
    vim
    firefox
    git
    i3
    gnome.gnome-tweaks
    gnome.dconf-editor
    polybar
    zsh
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
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
  ];

  # Any other configurations that don't fit into specific modules
  # or that you want to keep in the main file can go here
  system.stateVersion = "24.05";
}
