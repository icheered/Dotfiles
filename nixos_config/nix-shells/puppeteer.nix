{ pkgs }:

let
  puppeteerDeps = with pkgs; [
    glib
    nss
    nspr
    atk
    at-spi2-atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    gtk3
    libdrm
    libxkbcommon
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    mesa
    pango
    alsa-lib
  ];
in
{
  buildInputs = puppeteerDeps;

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath puppeteerDeps}:$LD_LIBRARY_PATH
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
    export PUPPETEER_EXECUTABLE_PATH=${pkgs.chromium}/bin/chromium
  '';
}
