{ config, pkgs, ... }:
let
  username = "tjbakker";
in
{
  systemd.user.services.espanso = {
    description = "Espanso text expander";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.espanso}/bin/espanso daemon";
      Restart = "on-failure";
    };
  };

  systemd.user.services.stackstorage = {
    description = "StackStorage file sync";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.appimage-run}/bin/appimage-run /home/tjbakker/Dotfiles/appimages/stackstorage.AppImage";
      Restart = "on-failure";
    };
  };

  # Ensure appimage-run is available in the system
  environment.systemPackages = [ pkgs.appimage-run ];
}