{ pkgs, ... }: {
  my = {
    home = {
      programs.kitty = {
        enable = true;
        extraConfig = builtins.readFile <config/kitty/conf>;
      };
    };
  };
}
