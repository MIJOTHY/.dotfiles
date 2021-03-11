{ config, options, lib, pkgs, ... }:
with lib;
{
  config = {
    my.home.home.file = {
      ".lein/profiles.clj".source = <config/lein/profiles.clj>;
    };
    my.packages = with pkgs; [
      clojure
      joker
      leiningen
    ];
  };
}
