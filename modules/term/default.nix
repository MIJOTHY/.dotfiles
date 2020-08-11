{ config, pkgs, lib, ... }:
{
  imports = [
    ./ssh.nix
  ];
  my = {
    # home = {
    #   home = {
    # xdg.configFile = {
    #   "zsh/rc.d/rc.fzf.zsh".source = <config/fzf/rc.zsh>;
    #   "zsh/rc.d/rc.term.zsh".text = ''
    #     alias mkdir='mkdir -p'
    #     alias cat='bat -p'
    #     alias wget='wget -c'
    #     alias bc='bc -lq'
    #     alias rg='rg --hidden'
    #     alias tree="tree -a -I '.git'"
    #     alias grep='grep --color=auto'
    #     alias fgrep='fgrep --color=auto'
    #     alias egrep='egrep --color=auto'
    #     alias exa='exa -h --group-directories-first --git'
    #     alias ls=exa
    #     alias l='exa -1a'
    #     alias ll='exa -la'
    #     alias lt='exa -lm -s modified'
    #   '';
    # };
    #   };
    # };

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
