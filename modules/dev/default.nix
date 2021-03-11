{ pkgs, lib, ... }: {
  imports = [ ./default.darwin.nix ];
  my.packages = with pkgs; [
    gnumake
    shellcheck
    nixfmt
    rnix-lsp
    niv

    plantuml
  ];
}
