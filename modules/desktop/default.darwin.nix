{ config, pkgs, lib, ... }: {
  imports = [
    ./darwin/yabai.nix
    ./darwin/skhd.nix
    ./darwin/spacebar.nix
  ];
 
  my = {
    home.xdg.configFile."homebrew/Brewfile" = {
      text = let casks = map (v: ''cask "${v}"'') config.my.casks;
      in ''
        tap "homebrew/core"
        tap "homebrew/bundle"
        tap "homebrew/services"
        tap "homebrew/cask"
        tap "homebrew/cask-versions"
        ${lib.concatStringsSep "\n" casks}
      '';
      onChange = "brew bundle || true";
    };
    env.HOMEBREW_BUNDLE_FILE = "$XDG_CONFIG_HOME/homebrew/Brewfile";

    packages = [];
    casks = [];
  };

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
