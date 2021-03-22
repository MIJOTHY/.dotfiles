{ config, options, lib, pkgs, ... }:
let
  withSync = opts: ({
    onChange = "${config.home-manager.users.${config.my.username}.xdg.configHome}/emacs/bin/doom sync";
  } // opts);
in
with lib;
{
  config = {
    my = {
      home = {
        programs.emacs = {
          enable = true;
          package = pkgs.emacs;
        };
        
        xdg = {
          configFile = {
            "doom-config/config.el" = withSync {
              text = builtins.readFile ../../config/emacs/config.el + ''
                ;; projectile settings
                (setq projectile-project-search-path
                  '("~/${config.my.work.dir}/"
                    "~/${config.my.personal.dir}/"))
              '';
            };

            "doom-config/init.el" = withSync { source = ../../config/emacs/init.el; };
            "doom-config/packages.el" = withSync { source = ../../config/emacs/packages.el; };

            # https://discourse.nixos.org/t/advice-needed-installing-doom-emacs/8806/8
            "emacs" = {
              source = pkgs.fetchFromGitHub {
                owner = "hlissner";
                repo = "doom-emacs";
                rev = "5e7864838a7f65204b8ad3fe96febc603675e24a";
                sha256 = "iDoNvXdak+D1qYCyKMUuti3NtKKIOuRXtna5HXc5jyk=";
              };
              onChange = "${pkgs.writeShellScript "doom-change" ''
                export DOOMDIR="${config.my.env.DOOMDIR}"
                export DOOMLOCALDIR="${config.my.env.DOOMLOCALDIR}"
                if [ ! -d "$DOOMLOCALDIR" ]; then
                  ${config.home-manager.users.${config.my.username}.xdg.configHome}/emacs/bin/doom -y install
                else
                  ${config.home-manager.users.${config.my.username}.xdg.configHome}/emacs/bin/doom -y sync -u
                fi
              ''}"; 
            };
          };
        };  
      };

      packages = with pkgs; [
        ## Doom dependencies
        git
        (ripgrep.override {withPCRE2 = true;})

        ## Optional dependencies
        fd                  # faster projectile indexing
        imagemagick         # for image-dired
        zstd                # for undo-fu-session/undo-tree compression

        ## Module dependencies
        # :tools editorconfig
        editorconfig-core-c # per-project style config
        # :tools lookup & :lang org +roam
        sqlite
      ];
      env = {
        # FIXME: use sessionPath and sessionVariables instead. These are currently infinitely recursing though
        PATH = [ "${config.home-manager.users.${config.my.username}.xdg.configHome}/emacs/bin" "$PATH" ];
        DOOMDIR = "${config.home-manager.users.${config.my.username}.xdg.configHome}/doom-config";
        DOOMLOCALDIR = "${config.home-manager.users.${config.my.username}.xdg.configHome}/doom-local";
      };
    };
  };
}
