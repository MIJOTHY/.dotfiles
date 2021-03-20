{ pkgs, stdenv, binCommon, ... }:

stdenv.writeShellScriptBin "cdr" ''
  ${binCommon.strictMode}

  findRoot() {
    ${binCommon.repoRoot}
  }

  main() {
    cd $(findRoot)
  }

  main "$@"
''
