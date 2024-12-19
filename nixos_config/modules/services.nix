{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "tjbakker";
in
{

# For ZSA keyboard
services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
    # Rule for the Moonlander
    SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
    # Keymapp / Wally Flashing rules for the Moonlander
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
  '';

  # Create plugdev group and add your user to it
  users.groups.plugdev = {};
  users.users.${username}.extraGroups = [ "plugdev" ];

  services.openssh = {
    enable = true;
    ports = [471];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

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
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      [
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.gst_all_1.gst-plugins-ugly
      ];
}
