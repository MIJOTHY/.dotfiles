{ config, options, pkgs, ... }:
{
  config = {
    my.packages = with pkgs; [
      (agda.withPackages (p: [ p.standard-library ]))
    ];
  };
}
