{
  description = "$HOME/.dotfiles";

  inputs = {
    darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin/master";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };
    private = {
      url = "path:/Users/griffithsjr/.private";
      flake = false;
    };
    nixpkgs = {
      # nixpkgs rev pointing to pre-nix-flake-info removal in `nixos/nix` in
      # https://github.com/NixOS/nix/commit/66fa1c7375e4b3073a16df4678cf1d37446ed20b
      url = "github:NixOS/nixpkgs?ref=5b3290333a2048e07aadaa2dc934a2335525ba0a";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, private, ... }:
    let
      pkgs = import nixpkgs {};
      secrets = import private;
    in
      {
        darwinConfigurations = {
          bootstrap = darwin.lib.darwinSystem {
            modules = [
              ./darwin/bootstrap.nix
            ];
          };

          james-macbook = darwin.lib.darwinSystem {
            modules = [
              ./hosts/james-macbook/default.nix
              { config.my.secrets = secrets; }
              ./default.nix
              ./darwin/default.nix
              home-manager.darwinModules.home-manager
              { nixpkgs.overlays = import ./packages; }
              { home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;}
            ];
          };
        };

        devShell."x86_64-darwin" = import ./shell.nix {
          pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        };
      };
}
