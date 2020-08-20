{ lib, pkgs, ... }: {
  my = {
    home = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        oh-my-zsh = {
          enable = true;
        };
      };

      xdg.configFile."zsh" = {
        source = <config/zsh>;
        recursive = true;
      };
    };

    packages = with pkgs; [
      nix-zsh-completions
      bat
      exa
      fasd
      fd
      fzf
      htop
      tldr
      tree
      (ripgrep.override { withPCRE2 = true; })
    ];

    env.ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
    env.ZSH_CACHE = "$XDG_CACHE_HOME/zsh";
    
  };
}
