{ lib, ... }:

let
  configDir = "/home/raiha/.config/home-manager";
  applyCommand = "home-manager switch --flake ${configDir}#gx10";
in
{
  programs.zsh.shellAliases = {
    hm-apply = lib.mkForce applyCommand;
    hm-update = lib.mkForce "nix flake update --flake ${configDir} && ${applyCommand}";
  };
}
