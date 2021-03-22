{ config, options, lib, ... }:
with lib;
let
  mkOptionStr = value: mkOption {
      type = types.str;
      default = value; 
  };
  projectOptions = {
    options = with types; {
      dir = mkOption {
        type = str;
        description = ''
          Directory in which projects are kept
          '';
      };
      username = mkOption {
        type = str;
        description = ''
          Git username
          '';
      };
      email = mkOption {
        type = str;
        description = ''
          Git email address
          '';
      };
    };
  };
in 
  { 
    options = {
      my = { 
        # Machine defaults
        username = mkOptionStr "griffithsjr";
        fullname = mkOptionStr "James Griffiths";

        personal = mkOption {
          type = with types; submodule projectOptions;
          description = ''
            Personal git and project params
            '';
        };

        work = mkOption {
          type = with types; submodule projectOptions;
          description = ''
            Work git and project params
            '';
        };

        secrets = {
          work = {
            dir = mkOption { type = types.str; };
            username = mkOption { type = types.str; };
            email = mkOption { type = types.str; };
            id_rsa = mkOption { type = types.str; };
            id_rsa_pub = mkOption { type = types.str; };
          };

          personal = {
            id_rsa = mkOption { type = types.str; };
          };
        };

        # Convenience aliases.
        home = mkOption { type = options.home-manager.users.type.functor.wrapped; };
        user = mkOption { type = options.users.users.type.functor.wrapped; };
        packages = mkOption {
          type = types.listOf types.package;
          description = "The set of packages to appear in the user environment.";
        };

        # Shell and environment.
        env = mkOption {
          type = with types;
            attrsOf (either (either str path) (listOf (either str path)));
          apply = mapAttrs (n: v:
            if isList v
            then concatMapStringsSep ":" (x: toString x) v
            else (toString v));
        };

        init = mkOption {
          type = types.lines;
          description = ''
            An init script that runs after the environment has been rebuilt or
            booted. Anything done here should be idempotent and inexpensive.
          '';
          default = "";
        };

        alias = mkOption {
          type = with types; nullOr (attrsOf (nullOr (either str path)));
        };
      };
    };  

    config = {
      home-manager.users.${config.my.username} = mkAliasDefinitions options.my.home;
      users.users.${config.my.username} = mkAliasDefinitions options.my.user;
      my.user.packages = config.my.packages;
      my.home.home.stateVersion = "20.09";
      environment.extraInit = let
        exportLines = mapAttrsToList (n: v: ''export ${n}="${v}"'') config.my.env;
      in ''
        ${concatStringsSep "\n" exportLines}
        ${config.my.init}
      '';
    };

  }
