{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    casks = [
      "ghostty"
      "zoom"
      "claude-code"
    ];

    masApps = {
      # "Xcode" = 497799835;
    };
  };
}
