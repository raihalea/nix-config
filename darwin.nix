{ pkgs, ... }:

{
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.enable = false;
  
  home-manager.backupFileExtension = "backup";
  programs.zsh.enable = true;
  system.stateVersion = 4;

  system.primaryUser = "raiha";
  users.users.raiha = {
    name = "raiha";
    home = "/Users/raiha";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    
    # 既存のBrewが入っていてもエラーを出さない設定
    onActivation = {
      autoUpdate = true;       # 更新するか
      upgrade = true;          # アップグレードするか
      cleanup = "zap";       # 記述にないアプリを自動削除したい場合は "zap" にする (最初はコメントアウト推奨)
    };

    casks = [
      "docker"
      "ghostty"
      "zoom"
      "claude-code"
    ];

    # Mac App Store アプリ (IDで指定)
    masApps = {
      # "Xcode" = 497799835;
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false; # 最近使ったアプリを非表示
    };
    finder = {
      AppleShowAllFiles = true; # 隠しファイルを表示
    };
  };
}