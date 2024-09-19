{
  pkgs ? import <nixpkgs> { },
}:
let
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
  buildInputs = with pkgs; [
    nodejs
    yarn
    openssl
    pkg-config
    prisma-engines
    loadingScript
    # Add other common tools you use across projects
  ];
  shellHook = ''
    export PRISMA_ENGINES_MIRROR=https://prisma-builds.s3-eu-west-1.amazonaws.com
    export PRISMA_CLI_QUERY_ENGINE_TYPE=binary
    export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs.prisma-engines}/lib/libquery_engine.node"
    export PRISMA_QUERY_ENGINE_BINARY="${pkgs.prisma-engines}/bin/query-engine"
    export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs.prisma-engines}/bin/schema-engine"
    export PRISMA_MIGRATION_ENGINE_BINARY="${pkgs.prisma-engines}/bin/migration-engine"
    export PRISMA_FMT_BINARY="${pkgs.prisma-engines}/bin/prisma-fmt"
    show_loading
  '';
}
