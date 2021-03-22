{ pkgs, ... }: {
  my = {
    packages = with pkgs; [
      terraform
      awscli2
      aws-iam-authenticator
      kubectl
      kustomize
    ];
  };

  homebrew = {
    casks = [
      "docker"
    ];
  };
}
