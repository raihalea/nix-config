{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # WSL専用パッケージをここに追加
    unzip
    jq
    chromium
  ];
}
