# modules/dotfiles.nix
{ config, pkgs, ... }:

let
  username = "tjbakker"; 
in
{
  # Set up dotfiles
  system.activationScripts.dotfiles = ''
    # Create symlinks for dotfiles in the home directory
    for file in /home/${username}/Dotfiles/.*; do
      if [ -f "$file" ]; then
        ln -sf "$file" /home/${username}/
      fi
    done

    # Create .config directory if it doesn't exist
    mkdir -p /home/${username}/.config/i3
    mkdir -p /home/${username}/.config/polybar

    # Create symlinks for .config files
    ln -sf /home/${username}/Dotfiles/.config/i3/config /home/${username}/.config/i3/config
    ln -sf /home/${username}/Dotfiles/.config/polybar/config.ini /home/${username}/.config/polybar/config.ini

    # Set correct permissions
    chown -R ${username}:users /home/${username}
  '';
}
