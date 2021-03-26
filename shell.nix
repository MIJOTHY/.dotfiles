# Flakes are available after a specific version of nix, and have to be explicitly
# enabled in some config (or passed a flag). Since we haven't set up our nix
# config yet, this nix-shell provides a nix version with flakes from which we
# can bootstrap our dotties
{
  pkgs ? import (builtins.fetchTarball {
    # nixpkgs rev pointing to pre-nix-flake-info removal in `nixos/nix` in
    # https://github.com/NixOS/nix/commit/66fa1c7375e4b3073a16df4678cf1d37446ed20b
    url = "https://github.com/NixOS/nixpkgs/archive/5b3290333a2048e07aadaa2dc934a2335525ba0a.tar.gz";
    sha256 = "1sj12av64c50xh4i04w3ysnxqz9idvz37d6by3lbnxnhw1i7sqli";
  }) {}
}:
let
  pwd = builtins.toString ./.;
  nix-rebuild = pkgs.writeShellScriptBin "nix-rebuild" ''
    set -euo pipefail
     
    if [ "''${DEBUG:-false}" = true ]; then
      set -x
    fi

    main() {
      cmd="''${1:-switch}"

      flags=()      
      if [ "''${DEBUG:-false}" = true ]; then
        flags+=(--show-trace)
        flags+=(--verbose)
      fi

      ${pkgs.nixUnstable}/bin/nix build ${pwd}\#darwinConfigurations.$(hostname -s).system "''${flags[@]}"
      /run/current-system/sw/bin/darwin-rebuild "$cmd" --flake . "''${flags[@]}"
    }
    
    main "$@"
  '';
in
pkgs.mkShell {
  name = "bootstrap-dotfiles";
  buildInputs = [
    nix-rebuild
    pkgs.nixUnstable
    pkgs.bash
    pkgs.git
  ];
}
