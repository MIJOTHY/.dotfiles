{ config, options, lib, pkgs, ... }:
with lib;
{
  config = {
    my.packages = with pkgs; [
      (agda.withPackages (p: [ p.standard-library ]))
    ];

    my.home.home.file = {
      defaults = {
        target = ".agda/defaults";
        text = ''
          standard-library
        '';
      };
    };
  };
}
