{ config, options, lib, pkgs, ... }:
{ my = {
    home.programs.vim = {
      enable = true;
      extraConfig = builtins.readFile ../../config/vim/init.vim;
    };
  };
}
