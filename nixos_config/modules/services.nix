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

  # Prisma:
  environment.variables.PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
  environment.variables.PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
  environment.variables.PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";

  # Nautilus audio/video properties
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
  pkgs.gst_all_1.gst-plugins-good
  pkgs.gst_all_1.gst-plugins-bad
  pkgs.gst_all_1.gst-plugins-ugly
  pkgs.gst_all_1.gst-plugins-libav
]
}
