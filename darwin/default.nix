{ config, pkgs, inputs, ... }:

{
  imports = [
    ./bootstrap.nix
  ];

  homebrew = {
    enable = true;
    cleanup = "zap";
    taps = [
      "homebrew/core"
      "homebrew/bundle"
      "homebrew/services"
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
  };

  # https://github.com/LnL7/nix-darwin/issues/139
  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = config.environment.systemPackages
            ++ config.home-manager.users.${config.my.username}.home.packages;
    pathsToLink = "/Applications";
  });

  system.activationScripts.applications.text = pkgs.lib.mkForce (''
      echo "setting up /Applications/Nix..."
      rm -rf /Applications/Nix
      mkdir -p /Applications/Nix
      chown ${config.my.username} /Applications/Nix
      echo "Looking for files in ${config.system.build.applications}/Applications"
      find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
        src="$(/usr/bin/stat -f%Y $f)"
        appname="$(basename $src)"
        osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
    done
  '');
}
