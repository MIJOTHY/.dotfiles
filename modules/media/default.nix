{ pkgs, ... }:
{
  my = {
    packages = with pkgs; [
      my.gimp
    ];
  };
}
