{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/desktop

    ../../modules/dev/default.nix
    ../../modules/dev/agda.nix
    ../../modules/dev/clojure.nix

    ../../modules/editors/emacs.nix
    ../../modules/editors/nvim.nix

    ../../modules/media/default.nix

    ../../modules/ops/default.nix

    ../../modules/term/default.nix
    ../../modules/term/direnv.nix
    ../../modules/term/git.nix
    ../../modules/term/zsh.nix
    ../../modules/term/kitty.nix
    ../../modules/term/ssh.nix

    ../../modules/web/default.nix
    ../../modules/web/firefox.nix
  ];

  nix = {
    # $ sysctl -n hw.ncpu
    maxJobs = 12;
    buildCores = 12;
  };

  system.activationScripts.extraUserActivation.text = ''
    echo "Writing additional defaults..."
    cp ${../../config/defaults/com.apple.HIToolbox.plist} ~/Library/Preferences/com.apple.HIToolbox.plist
  '';

  my = {
    user.home = "/Users/griffithsjr";
    user.name = "griffithsjr";
    personal = {
      dir = "personal";
      username = "MIJOTHY";
      email = "james.griffiths.2222@gmail.com";
    };

    work = {
      dir = config.my.secrets.work.dir;
      username = config.my.secrets.work.username;
      email = config.my.secrets.work.email;
    };
  };
}
