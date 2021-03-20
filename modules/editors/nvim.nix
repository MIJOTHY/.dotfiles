{ config, options, lib, pkgs, ... }:
with lib;
{ my = {
    home.programs.neovim = {
      # FIXME: broken on unstable
      # builder for '/nix/store/faxl6kkidy5b9pnlm19c8ysybjba0s16-neovim-0.4.4.drv' failed with exit code 1; last 5 log lines:
      # Generating remote plugin manifest
      # Error detected while processing function remote#host#UpdateRemotePlugins:
      # line   16:
      # E482: Can't open file /nix/store/xhsy3vxdvbygibg1d2vikc12cc5csmpb-neovim-0.4.4/rplugin.vim for writing: permission denied
      # Generating rplugin.vim failed!
      enable = false;
      package = pkgs.neovim;
      withPython = false;
      withPython3 = false;
      withRuby = false;
      viAlias = true;
      vimAlias = true;
      extraConfig = builtins.readFile ../../config/nvim/init.vim;
    };
  };
}
