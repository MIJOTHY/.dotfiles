{ config, pkgs, ... }:

{
  imports = 
  [ <home-manager/nix-darwin> 
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  
  environment.shells = [ pkgs.zsh ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix = {
    # Auto-upgrade Nix package.
    package = pkgs.nix;

    readOnlyStore = true;

    gc = {
      # Automatically run the Nix garbage collector.
      automatic = false;

      # Run the collector as the current user.
      user = config.my.username;

      options = "--delete-older-than 10d";
    };
  };

  nixpkgs.overlays = import ./packages;
  nixpkgs.config.allowUnfree = true; 

  home-manager.useUserPackages = true;

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
