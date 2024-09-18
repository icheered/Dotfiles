{ config, pkgs, lib, ... }:

let
  appImagePath = /home/tjbakker/Dotfiles/appimages/stackstorage.AppImage;

  stackStorage = pkgs.writeShellScriptBin "stackstorage" ''
    ${pkgs.appimage-run}/bin/appimage-run ${appImagePath}
  '';

  stackStorageDesktopItem = pkgs.makeDesktopItem {
    name = "stackstorage";
    exec = "stackstorage";
    icon = "stackstorage";  # You might need to provide an icon separately
    desktopName = "StackStorage";
    genericName = "File Sync";
    categories = [ "Network" "FileTransfer" ];
  };
in
{
  environment.systemPackages = [
    stackStorage
    pkgs.appimage-run  # Make sure appimage-run is available
  ] ++ lib.optionals config.services.xserver.enable [
    stackStorageDesktopItem
  ];
}