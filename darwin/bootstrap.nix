{ config, pkgs, inputs, ... }:

{
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  services.nix-daemon.enable = true;

  users.nix.configureBuildUsers = true;

  nix = {
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    readOnlyStore = true;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';

    gc = {
      # Automatically run the Nix garbage collector.
      automatic = false;

      # Run the collector as the current user.
      user = config.my.username;

      options = "--delete-older-than 10d";
    };

  };

  nixpkgs = {
    config.allowUnfree = true;
  };
}
