{
  description = "Home Manager configuration for WSL and macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-darwin
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, darwin, ... }: {

    # ---------------------------------------------------------------
    # 1. WSL用設定 (Home Manager Standalone)
    # コマンド: home-manager switch --flake .#wsl
    # ---------------------------------------------------------------
    homeConfigurations."wsl" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        ./home.nix
        ./modules/common
        ./modules/wsl
      ];
    };

    # ---------------------------------------------------------------
    # 2. macOS用設定 (nix-darwin)
    # コマンド: nix run nix-darwin -- switch --flake .#raiha
    # ---------------------------------------------------------------
    darwinConfigurations."raiha" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./darwin.nix
        ./modules/darwin/homebrew.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users."raiha" = { ... }: {
            imports = [
              ./home.nix
              ./modules/common
              ./modules/darwin
            ];
          };
        }
      ];
    };
  };
}
