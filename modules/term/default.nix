{ config, pkgs, lib, ... }:
{
  imports = [
    ./ssh.nix
  ];
  my = {
    home = {
      xdg.configFile = {
        "zsh/rc.d/rc.fzf.zsh".source = <config/fzf/rc.zsh>;
        "zsh/rc.d/rc.term.zsh".text = ''
            alias mkdir='mkdir -p'
            alias tree="tree -a -I '.git'"
            alias exa='exa -h --group-directories-first --git'
            alias ls=exa
            alias l='exa -1a'
            alias ll='exa -la'
            alias lt='exa -lm -s modified'
          '';
      };

      programs = {
        fzf = {
          enable = true;
          enableZshIntegration = true;
        };
      };
    };

    packages = with pkgs; [
      coreutils
      curl
      entr
      file
      jq
      lastpass-cli
      yq
      zip
    ];
  };
}
