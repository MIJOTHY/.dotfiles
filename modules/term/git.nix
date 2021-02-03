{ config, pkgs, ... }:
{
  my = {
    home = {
      xdg.configFile."git/.gitmessage".source = <config/git/.gitmessage>;
      programs = {
        git = {
          enable = true;
          userName = config.my.fullname;
          userEmail = config.my.personal.email;
          extraConfig = {
            pull = {
              ff = "only";
            };
            core = {
              editor = "vim";
            };
            commit = {
              template = "${config.home-manager.users.${config.my.username}.xdg.configHome}/git/.gitmessage";
            };
          };
          includes = [
            {
              condition = "gitdir:~/${config.my.personal.dir}/";
              contents = {
                user = {
                  email = config.my.personal.email;
                };
              };
            }
            {
              condition = "gitdir:~/${config.my.work.dir}/";
              contents = {
                user = {
                  email = config.my.work.email;
                };
              };
            }
          ];
        };
      };
    };
  };
}
