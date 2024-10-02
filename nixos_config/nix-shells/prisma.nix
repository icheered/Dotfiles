{ pkgs }:

{
  buildInputs = with pkgs; [
    prisma-engines
  ];

  shellHook = ''
    export PRISMA_ENGINES_MIRROR=https://prisma-builds.s3-eu-west-1.amazonaws.com
    export PRISMA_CLI_QUERY_ENGINE_TYPE=binary
    export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs.prisma-engines}/lib/libquery_engine.node"
    export PRISMA_QUERY_ENGINE_BINARY="${pkgs.prisma-engines}/bin/query-engine"
    export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs.prisma-engines}/bin/schema-engine"
    export PRISMA_FMT_BINARY="${pkgs.prisma-engines}/bin/prisma-fmt"
  '';
}
