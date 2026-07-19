{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unzip
    jq
    tmux
    ripgrep
    ffmpeg
  ];
}
