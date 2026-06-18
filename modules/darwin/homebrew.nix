{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
      "k1Low/tap"
    ];

    brews = [
      "k1Low/tap/mo"
    ];

    casks = [
      "ghostty"
      "zoom"
      "claude-code"
      "blackhole-2ch"
      "cmux"
      "tailscale"
      "windows-app"
      "antigravity-cli"
    ];

    masApps = {
      # "Xcode" = 497799835;
    };
  };
}
