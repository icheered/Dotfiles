{ pkgs }:

{
  buildInputs = with pkgs; [
    nodejs
    yarn
    openssl
    pkg-config
  ];

  shellHook = ''
    # Add any Node.js specific environment setup here
  '';
}
