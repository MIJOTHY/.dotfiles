{ config, options, lib, pkgs, ... }:
with lib;
{ my = {
    home.programs.neovim = {
      enable = true;
      package = pkgs.neovim;
      withPython = false;
      withPython3 = false;
      withRuby = false;
      viAlias = true;
      vimAlias = true;

      configure = {
        customRC = builtins.readFile <config/nvim/init.vim>;
      };
    };
  };
}
