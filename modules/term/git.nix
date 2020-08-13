{ config, pkgs, ... }:
{
  my = {
    home = {
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
