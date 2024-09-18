# modules/zsh.nix
{ config, pkgs, ... }:

{
  # Enable zsh system-wide
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "sudo" ];
      theme = "robbyrussell";
    };
  };

  # Set zsh as the default shell system-wide
  users.defaultUserShell = pkgs.zsh;
}
