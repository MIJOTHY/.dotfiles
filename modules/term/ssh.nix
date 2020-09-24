{ config, lib, ... }:
{
  my = {
    home = {
      home.file = {
        ".ssh/id_rsa_personal".text = config.my.secrets.personal.id_rsa;
        ".ssh/id_rsa_personal.pub".source = <config/ssh/id_rsa_personal.pub>;
        ".ssh/id_rsa_work".text = config.my.secrets.work.id_rsa;
        ".ssh/id_rsa_work.pub".text = config.my.secrets.work.id_rsa_pub;
      };

      programs.ssh = {
        enable = true;
        hashKnownHosts = true;
        extraConfig = ''
          IgnoreUnknown UseKeychain
          UseKeychain yes
          AddKeysToAgent yes
          IdentitiesOnly yes
        '';
        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_rsa_work";
          };
          "personal.github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_rsa_personal";
          };
        };
      };
    };
  };
}
