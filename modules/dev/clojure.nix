{ config, options, lib, pkgs, ... }:
with lib;
{
  config = {
    my = {
      home.home.file = {
        ".lein/profiles.clj".source = ../../config/lein/profiles.clj;
      };
      packages = with pkgs; [
        clojure
        joker
        (leiningen.override { jdk = openjdk11; })
      ];
      env.LEIN_USE_BOOTCLASSPATH="no";
    };
  };
}
