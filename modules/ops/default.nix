{ pkgs, ... }: {
  my = {
    packages = with pkgs; [
      terraform
      terraform-lsp
      awscli
      yaml-language-server
    ];

    casks = [ 
      "docker"
    ];
  };
}
