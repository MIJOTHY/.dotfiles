{ lib, pkgs, ... }:
{
  my.packages = with pkgs; [
   my.Slack
  ];
 
  my.casks = [
    "spotify"
    "google-chrome"
  ];
}
