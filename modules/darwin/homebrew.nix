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
      "blackhole-2ch"
      "cmux"
    ];

    masApps = {
      # "Xcode" = 497799835;
    };
  };
}
