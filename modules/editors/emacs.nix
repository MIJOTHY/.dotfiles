{ config, options, lib, pkgs, ... }:
with lib;
{
  config = {
    my = {
      home = {
        programs.emacs = {
          enable = true;
          package = pkgs.emacs;
        };

        xdg.configFile."doom/config.el".text =
          builtins.readFile <config/emacs/config.el> + ''
            ;; projectile settings
            (setq projectile-project-search-path
              '("~/${config.my.work.dir}/"
                "~/${config.my.personal.dir}/"))
          '';

        xdg.configFile."doom/init.el".source = <config/emacs/init.el>;
        xdg.configFile."doom/packages.el".source = <config/emacs/packages.el>;
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

      env.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];
    };

  };
}
