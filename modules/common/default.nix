{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    git
    git-secrets
    gh
    devenv
    awscli2
    uv
    nodejs_24
    hackgen-nf-font
  ];
}
