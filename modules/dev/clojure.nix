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
        (clj-kondo.override {
          graalvm11-ce = pkgs.graalvm11-ce.overrideAttrs (_ : {
              # FIXME:
              # jshell fails due to not being able to synchronise the history file
              # ```
              # > |  Welcome to JShell -- Version 11.0.10
              # |  For an introduction type: /help intro
              #
              # jshell> $1 ==> 2
              #
              # jshell> Exception in thread "main" java.lang.IllegalStateException: java.util.prefs.BackingStoreException: Synchronization failed for node '/tool/JShell/'
              # ```
              #
              # https://github.com/NixOS/nixpkgs/blob/194c1f6aae06239a9c2263066223dda28048b652/pkgs/development/compilers/graalvm/community-edition.nix#L216-L218
              doInstallCheck = false;
            });})
        (leiningen.override { jdk = openjdk11; })
      ];
      env.LEIN_USE_BOOTCLASSPATH="no";
    };
  };
}
