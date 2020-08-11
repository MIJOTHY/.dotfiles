{ pkgs, ... }:
{
  services = {
    yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = true;
      extraConfig = builtins.readFile <config/yabai/rc>;
    };
  };

  system.defaults.spaces.spans-displays = false;
}
