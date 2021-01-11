{ pkgs, ... }: {
  my = {
    packages = with pkgs; [
      direnv
      nix-direnv
    ];
    home = {
      programs = {
        direnv = {
          enable = true;
          enableNixDirenvIntegration = true;
        };
      };
      xdg.configFile."zsh/rc.d/rc.direnv.zsh".text =
        ''eval "$(direnv hook zsh)"'';
    };
  };
}
