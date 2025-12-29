{
  description = "Home Manager configuration for WSL and macOS";

  inputs = {
    # Nix Packages (Unstable channel)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      
      # home-manager switch --flake .#wsl
      "wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Linux (Intel/AMD)
        modules = [ ./home.nix ];
      };

      # home-manager switch --flake .#mac
      "mac" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Mac (M1/M2/M3...)
        modules = [ ./home.nix ];
      };

    };
  };
}