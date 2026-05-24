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
    ghq
    fzf
    bat
    devenv
    awscli2
    uv
    nodejs_24
    npm-check-updates
    hackgen-nf-font
  ];
}
