{ pkgs, ... }: {
  my = {
    packages = with pkgs; [
      terraform
      awscli2
    ];

    casks = [ 
      "docker"
    ];
  };
}
