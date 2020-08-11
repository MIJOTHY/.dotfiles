{ config, options, lib, pkgs, ... }:
with lib;
{ my = {
    home.programs.firefox = {
      enable = true;
      package = pkgs.my.Firefox;
    };
  };
}
