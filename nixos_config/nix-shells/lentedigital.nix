{
  pkgs ? import <nixpkgs> { },
}:

let
  node = import ./node.nix { inherit pkgs; };
  prisma = import ./prisma.nix { inherit pkgs; };
  puppeteer = import ./puppeteer.nix { inherit pkgs; };

  loadingScript = pkgs.writeScriptBin "show_loading" ''
    #!/usr/bin/env bash
    echo -n "Loading environment "
    for i in {1..3}; do
      for s in / - \\ \|; do
        echo -n "$s"
        sleep 0.1
        echo -n $'\b'
      done
    done
    echo " Done!"
  '';

in
pkgs.mkShell {
  buildInputs = node.buildInputs ++ prisma.buildInputs ++ puppeteer.buildInputs ++ [ loadingScript ];

  shellHook = ''
    ${node.shellHook}
    ${prisma.shellHook}
    ${puppeteer.shellHook}
    show_loading
  '';
}
