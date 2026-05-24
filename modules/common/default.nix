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
    lazygit
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
