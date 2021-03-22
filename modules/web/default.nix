{ lib, pkgs, ... }:
{
  my.packages = with pkgs; [
   my.Slack
  ];

  homebrew = {
    casks = [
      "spotify"
      "google-chrome"
    ];
  };
}
