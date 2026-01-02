{ config, pkgs, ... }:

let
  # OS判定
  isDarwin = pkgs.stdenv.isDarwin;
  username = "raiha";
  homePrefix = if isDarwin then "/Users" else "/home";
  
  # 設定ファイルの場所
  configDir = "${homePrefix}/${username}/.config/home-manager";

  # Applyコマンドの自動分岐
  # Mac: nix-darwin を使用
  # WSL: home-manager を使用
  applyCommand = if isDarwin 
    then "sudo nix run nix-darwin -- switch --flake ${configDir}#raiha" 
    else "home-manager switch --flake ${configDir}#wsl";

in
{
  # 基本設定
  home.username = username;
  home.homeDirectory = "${homePrefix}/${username}";
  home.stateVersion = "24.05";

  # ---------------------------------------------------------------------
  # パッケージ管理
  # ---------------------------------------------------------------------
  home.packages = with pkgs; (
    [
      git
      git-secrets
      gh
      devenv
      awscli2
      uv
      nodejs_24
      hackgen-nf-font
    ]
    # Macのみ (Darwin) 追加分
    ++ (pkgs.lib.optionals isDarwin [
      # 追加パッケージ
    ])
    # WSLのみ (Linux) 追加分
    ++ (pkgs.lib.optionals (!isDarwin) [
      # 追加パッケージ
    ])
  );

  # ---------------------------------------------------------------------
  # Git 設定
  # ---------------------------------------------------------------------
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "raiha";
        email = "68338762+raihalea@users.noreply.github.com";
      };
      init = {
        defaultBranch = "main";
        templateDir = "${config.home.homeDirectory}/.git-templates/git-secrets";
      };
      pull.rebase = true;

      secrets = {
        providers = "git secrets --aws-provider";
        patterns = [
          "(A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{16}"
          "(\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)(\"|')?\\s*(:|=>|=)\\s*(\"|')?[A-Za-z0-9/\\+=]{40}(\"|')?"
          "(\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\\s*(:|=>|=)\\s*(\"|')?[0-9]{4}\\-?[0-9]{4}\\-?[0-9]{4}(\"|')?"
        ];
        allowed = [
          "AKIAIOSFODNN7EXAMPLE"
          "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
        ];
      };
    };
  };

  # ---------------------------------------------------------------------
  # Zsh 設定
  # ---------------------------------------------------------------------
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -la";
      
      # 設定変更を反映する (Mac/WSL自動判別)
      hm-apply = applyCommand;
      
      # パッケージを更新して反映する
      hm-update = "nix flake update --flake ${configDir} && ${applyCommand}";
      
      # ゴミ掃除
      hm-clean = "nix-collect-garbage -d";
    };
    
    # 起動時のスクリプト
    initContent = ''
      export EDITOR=vim
      
      # Homebrewの設定 (Mac用)
      if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
      fi
    '';
  };

  # ---------------------------------------------------------------------
  # Bash WSL用
  # ---------------------------------------------------------------------
  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -x "$HOME/.nix-profile/bin/zsh" ]; then
        exec "$HOME/.nix-profile/bin/zsh"
      fi
    '';
  };

  # ---------------------------------------------------------------------
  # Starship
  # ---------------------------------------------------------------------
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$directory$git_branch$git_status$nix_shell$package$fill$cmd_duration$line_break$character";
      right_format = "$time";
      add_newline = true;

      directory = {
        truncation_length = 3;
        style = "bold blue";
      };

      git_branch = {
        symbol = " ";
        style = "bg:none fg:purple"; 
      };
      git_status = {
        style = "bg:none fg:red";
        format = "[$all_status$ahead_behind]($style) ";
      };

      nix_shell = {
        disabled = false;
        symbol = " ";
        format = "via [$symbol$state]($style) ";
      };

      package = {
        disabled = true;
      };
      python = {
        symbol = " ";
        format = "via [$symbol($version )]($style)";
      };
      nodejs = {
        symbol = " ";
        format = "via [$symbol($version )]($style)";
      };

      cmd_duration = {
        min_time = 2000;
        style = "yellow";
      };

      fill = {
        symbol = " ";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      
      time = {
        disabled = false;
        format = "[$time]($style)";
        time_format = "%R";
        style = "bg:none fg:grey";
      };
    };
  };

  # ---------------------------------------------------------------------
  # Direnv
  # ---------------------------------------------------------------------
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  
  home.sessionVariables = {
    # EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}