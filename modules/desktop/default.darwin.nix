{ config, pkgs, lib, ... }: {
  imports = [
    ./darwin/yabai.nix
    ./darwin/skhd.nix
    ./darwin/spacebar.nix
  ];
 
  fonts = {
    enableFontDir = true;
    fonts = [
      pkgs.font-awesome
      pkgs.hasklig
      pkgs.jetbrains-mono
    ];
  };

  # My default desktop system settings across all macOS/Darwin installs.
  system = {
    keyboard = {
      enableKeyMapping = true;
      userKeyMapping = [
        { HIDKeyboardModifierMappingSrc = 30064771129; # Caps Lock
          HIDKeyboardModifierMappingDst = 30064771302; # Right option
        }
        { HIDKeyboardModifierMappingSrc = 30064771130; # Windows key (left option)
          HIDKeyboardModifierMappingDst = 30064771127; # Command
        }
      ];
    };


    defaults = {
      NSGlobalDomain = {
        _HIHideMenuBar = true;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "bottom";
        showhidden = true;
        tilesize = 32;
        expose-animation-duration = "0.0";
      };

      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };

      loginwindow.DisableConsoleAccess = false;
    };
  };

  time.timeZone = "Europe/London";
}
