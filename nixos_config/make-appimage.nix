{ pkgs, lib, appimageTools }:

{ name, version, src, desktopName ? name, ... }:

let
  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 {
  inherit name version src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${lib.toLower name}
    
    # Find .desktop file
    DESKTOP_FILE=$(find ${appimageContents} -name '*.desktop' | head -n 1)
    if [ -n "$DESKTOP_FILE" ]; then
      install -m 444 -D "$DESKTOP_FILE" $out/share/applications/${desktopName}.desktop
      substituteInPlace $out/share/applications/${desktopName}.desktop \
        --replace 'Exec=AppRun' 'Exec=${lib.toLower name}'
    else
      echo "Warning: No .desktop file found"
    fi

    # Find icon file (preferring .png, but falling back to any image file)
    ICON_FILE=$(find ${appimageContents} -name '*.png' | head -n 1)
    if [ -z "$ICON_FILE" ]; then
      ICON_FILE=$(find ${appimageContents} -regex '.*\.\(png\|jpg\|jpeg\|svg\)' | head -n 1)
    fi
    if [ -n "$ICON_FILE" ]; then
      install -m 444 -D "$ICON_FILE" $out/share/icons/hicolor/512x512/apps/${desktopName}.png
    else
      echo "Warning: No icon file found"
    fi
  '';
}