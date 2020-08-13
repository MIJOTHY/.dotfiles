{ pkgs, ... }: {
  my = {
    packages = with pkgs; [
      terraform
      awscli
    ];

    casks = [ 
      "docker"
    ];
  };
}
