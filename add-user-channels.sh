#!/usr/bin/env sh

# This is nasty; on non-nixos systems, the file
# /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
# gets sourced by the relevant shell. This sets the NIX_PATH to
# "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"
# meaning user-local channels in $HOME/.nix-defexpr/channels aren't used
# This script prepends them to make sure they are used if present
# https://github.com/NixOS/nix/issues/2033

set -e

exportUserChannels='export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH' 

if ! test -L /etc/bashrc && ! grep -q "$exportUserChannels" /etc/bashrc; then
  if test -t 1; then
    read -p "Would you like to use per-user channels in /etc/bashrc? [y/n] " i
  fi
  case "$i" in
    y|Y)
      echo "$exportUserChannels" | sudo tee -a /etc/bashrc
      ;;
  esac
fi

if ! test -L /etc/zshrc && ! grep -q "$exportUserChannels" /etc/zshrc; then
  if test -t 1; then
    read -p "Would you like to use per-user channels in /etc/zshrc? [y/n] " i
  fi
  case "$i" in
    y|Y)
      echo "$exportUserChannels" | sudo tee -a /etc/zshrc
      ;;
  esac
fi
