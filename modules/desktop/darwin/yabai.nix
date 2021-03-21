{ pkgs, ... }:
{
  services = {
    yabai = {
      enable = true;
      package = pkgs.yabai;
      # Apparently not needed, as the scripting addition is injected
      # automatically?
      enableScriptingAddition = false;
      extraConfig = builtins.readFile ../../../config/yabai/rc;
    };
  };

  system.defaults.spaces.spans-displays = false;
}
