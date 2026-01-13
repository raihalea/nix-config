{ ... }:

{
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

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
    };
    finder = {
      AppleShowAllFiles = true;
    };
  };
}
