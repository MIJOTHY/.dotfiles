{ config, options, lib, pkgs, ... }:
with lib;
{
  config = {
    my.packages = with pkgs; [
      clojure
      joker
      leiningen
    ];
  };
}
