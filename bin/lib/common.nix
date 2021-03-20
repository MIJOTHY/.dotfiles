{ pkgs, ... }:
/* Common script fragments
*/
rec {
  debugFlag = ''
    if [ "''${DEBUG:-false}" = true ]; then
        set -x
    fi
  '';

  strictMode = ''
    set -euo pipefail
    shopt -s inherit_errexit

    ${debugFlag}
  '';

  repoRoot = ''
    local repoRoot
    repoRoot="$(${pkgs.git}/bin/git rev-parse --show-toplevel)"
    local root="''${repoRoot:?Couldn\'t find repo root - is git available?}"
    echo "$root"
  '';
}
