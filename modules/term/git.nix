{ config, pkgs, ... }: {
  my = {
    packages = with pkgs; [
      git
      gitAndTools.hub
      gitAndTools.diff-so-fancy
    ];

    home.home.file."${config.my.work.dir}/.gitconfig".text = ''
    [user]
        email = ${config.my.work.email}
    '';

    home.home.file."${config.my.personal.dir}/.gitconfig".text = ''
    [user]
        email = ${config.my.personal.email}
    '';

    home.xdg.configFile = {
      "git/ignore".text = "";
      "git/config".text = ''
      [user]
          name = ${config.my.fullname}
          email = ${config.my.personal.email}

      [pull]
          ff = only

      [includeIf "gitdir:~/${config.my.personal.dir}/"]
          path = ~/${config.my.personal.dir}/.gitconfig

      [includeIf "gitdir:~/${config.my.work.dir}/"]
          path = ~/${config.my.work.dir}/.gitconfig

      [core]
          editor = vim
      '';
    };
  };
}
