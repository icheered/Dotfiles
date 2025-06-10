{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (kicad.withPackages (ps: with ps; [
      kicad-symbols
      kicad-footprints
      kicad-packages3d
    ]))
  ];
}
