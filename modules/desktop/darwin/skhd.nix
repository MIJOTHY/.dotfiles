{ config, pkgs, ... }:
{
  services = {
    skhd = {
      enable = true;
      package = pkgs.skhd;
      skhdConfig = ''
        # Modes
        ## The default mode is for window manipulation
        :: default : yabai -m config active_window_border_color 0xff5795e8;\
                     yabai -m config normal_window_border_color 0x00555555;

        ## App mode is for starting apps and other things
        :: app @ : yabai -m config active_window_border_color 0xffff9900;\
                   yabai -m config normal_window_border_color 0xffff9900;

        ## Switch between modes
        ### 0x29 ;
        alt - 0x29 ; app
        app < alt - 0x29 ; default

        # Apps
        # FIXME: hack for not having applications available in the env
        app < alt - w : open -na /Applications/Nix/Firefox.app
        app < alt - e : open -na /Applications/Nix/Emacs.app
        app < alt - t : kitty
      '' + builtins.readFile <config/skhd/rc>;
    };
  };

  my.packages = [
    pkgs.skhd
  ];
}
