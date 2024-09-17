# modules/zsh.nix
{ config, pkgs, ... }:

{
  # Enable zsh system-wide
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "sudo" ];
      theme = "robbyrussell";
    };
  };

  # Add zsh plugins
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  '';

  # Set zsh as the default shell system-wide
  users.defaultUserShell = pkgs.zsh;
}