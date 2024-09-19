{ config, pkgs, ... }:

let
  username = "tjbakker";
in
{
  networking.hostName = "NixOSDesktop"; # Define your hostname.

  # Add the macropad device to the udev rules
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1189", ATTRS{idProduct}=="8890", MODE="0666", GROUP="users"
  '';

}
