{ config, pkgs, ... }:
{
  services = {
    spacebar = {
      enable = true;
      package = pkgs.spacebar;
      extraConfig = builtins.readFile ../../../config/spacebar/rc;
    };
  };
}
