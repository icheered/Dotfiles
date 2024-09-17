# modules/base.nix
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
}
