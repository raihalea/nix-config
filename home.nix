{ config, pkgs, ... }:

{
  home.username = "raiha";
  home.homeDirectory = "/home/raiha";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  # environment.
  home.packages = with pkgs; [
    git
    devenv
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "raiha";
        email = "68338762+raihalea@users.noreply.github.com";
      };
      init = {
        defaultBranch = "main";
      };
      pull.rebase = true;
    };
  };

  # zsh設定
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -la";
      update = "home-manager switch";
    };
    
    initContent = ''
      export EDITOR=vim
    '';
  };

  # Bashの設定 (WSLでZshを起動するためだけに使用)
  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -x "$HOME/.nix-profile/bin/zsh" ]; then
        exec "$HOME/.nix-profile/bin/zsh"
      fi
    '';
  };

  # Starshipの設定
  programs.starship = {
    enable = true;
    
    # zshとの統合を有効化
    enableZshIntegration = true;

    settings = {
      # 1. 全体のフォーマット設定
      # 左側に表示する項目
      format = "$directory$git_branch$git_status$nix_shell$package$fill$cmd_duration$line_break$character";
      # 右側に表示する項目（空の場合は無し）
      right_format = "$time";

      # 行間の空き（見やすくなります）
      add_newline = true;

      # ディレクトリ表示
      directory = {
        truncation_length = 3; # 長すぎるパスは省略
        style = "bold blue";   # 青色で強調
      };

      # Git設定 (開発に必須)
      git_branch = {
        symbol = " "; # アイコン
        style = "bg:none fg:purple"; 
      };
      git_status = {
        style = "bg:none fg:red";
        format = "[$all_status$ahead_behind]($style) ";
      };

      # Nix Shellの表示
      # devenv shellに入っている時にアイコンが出ます
      nix_shell = {
        disabled = false;
        impure_msg = "";
        pure_msg = "";
        symbol = " "; # Nixアイコン
        format = "via [$symbol$state]($style) ";
      };

      # 言語バージョン表示 (ファイルがある時だけ表示)
      package = {
        disabled = true; # ごちゃつくのが嫌ならtrue。表示したいならfalseへ。
      };
      python = {
        symbol = " ";
        format = "via [$symbol($version )]($style)";
      };
      nodejs = {
        symbol = " ";
        format = "via [$symbol($version )]($style)";
      };

      # コマンド実行時間 (時間がかかった時だけ表示)
      cmd_duration = {
        min_time = 2000; # 2秒以上かかったら表示
        style = "yellow";
      };

      # プロンプトの記号
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      
      # 右寄せの時間表示 (オプション)
      time = {
        disabled = false;
        format = "[$time]($style)";
        time_format = "%R"; # 24時間表記 (例: 14:30)
        style = "bg:none fg:grey";
      };
    };
  };

  # direnv の設定 (devenvとの連携に必須)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  
  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
