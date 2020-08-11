# Default configuration for all my uses of Nix (NixOS, Darwin).
{ config, pkgs, lib, options, ... }:
with builtins;
let
  inherit (lib) flatten;
  pwd = toPath ./.;
in {
  imports = flatten [
    # Configuration options.
    ./options.nix
    ./darwin-configuration.nix
  ];

  nix = {
    # Add my custom setup to the default Nix expression search path.
    nixPath =
      [ "config=${pwd}/config"
        "modules=${pwd}/modules" ];
  };

  my = {
    secrets = import ./.private/secrets.nix;

    # Homedir.
    home.xdg = {
      enable = true;
      configFile."zsh/rc.d/rc.nix.zsh".text = ''
        alias nix-env="NIXPKGS_ALLOW_UNFREE=1 nix-env"
        alias nix-shell="NIXPKGS_ALLOW_UNFREE=1 nix-shell"
        alias nix-test="make -C ${pwd} test"
        alias nix-switch="make -C ${pwd} switch"
        alias nix-rollback="make -C ${pwd} switch --rollback"
      '';
    };
  };

  environment = {
    variables = {
      # Force XDG defaults.
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_RUNTIME_DIR = "$HOME/.cache";

      PATH = "$PATH:$XDG_BIN_HOME";

      # Location, timezone and internationalisation.
      TZ = "Europe/London";
      LC_ALL = "en_GB.UTF-8";
      LANG = "en_GB.UTF-8";
      LANGUAGE = "en_GB.UTF-8";
    };
  };
}

