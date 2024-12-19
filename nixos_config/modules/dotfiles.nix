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
    mkdir -p /home/${username}/.config/kitty
    mkdir -p /home/${username}/.config/picom
    mkdir -p /home/${username}/.config/nvim
    mkdir -p /home/${username}/.config/Code/User/snippets

    # Create symlinks for .config files
    ln -sf /home/${username}/Dotfiles/.config/nvim /home/${username}/.config/nvim
    ln -sf /home/${username}/Dotfiles/.config/i3/config /home/${username}/.config/i3/config
    ln -sf /home/${username}/Dotfiles/.config/polybar/config.ini /home/${username}/.config/polybar/config.ini
    ln -sf /home/${username}/Dotfiles/.config/kitty/kitty.conf /home/${username}/.config/kitty/kitty.conf
    ln -sf /home/${username}/Dotfiles/.config/picom/picom.conf /home/${username}/.config/picom/picom.conf
    ln -sf /home/${username}/Dotfiles/.config/espanso /home/${username}/.config/
    ln -sf /home/${username}/Dotfiles/.config/pypoetry/config.toml /home/${username}/.config/pypoetry/config.toml
    ln -sf /home/${username}/Dotfiles/.config/vscode/settings.json /home/${username}/.config/Code/User/settings.json
    ln -sf /home/${username}/Dotfiles/.config/vscode/keybindings.json /home/${username}/.config/Code/User/keybindings.json
    ln -sf /home/${username}/Dotfiles/.config/vscode/snippets /home/${username}/.config/Code/User/snippets

    # Set correct permissions
    chown -R ${username}:users /home/${username}
  '';
}
