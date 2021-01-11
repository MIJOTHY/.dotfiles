{ config, pkgs, ... }: {
  my.packages = with pkgs; [
    gnumake
  ];
}
