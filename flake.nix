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
      ];
    };

    # (一応残しておきますが、Macは下のdarwinConfigurationsを使います)
    homeConfigurations."mac" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin; 
      modules = [ ./home.nix ];
    };

    # ---------------------------------------------------------------
    # 2. macOS用設定 (nix-darwin)
    # コマンド: nix run nix-darwin -- switch --flake .#raiha
    # ---------------------------------------------------------------
    darwinConfigurations."raiha" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        # Mac用の読み込み
        ./darwin.nix

        # Home Managerをdarwinのモジュールとして読み込む
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # home.nixの読み込み
          home-manager.users."raiha" = import ./home.nix;
        }
      ];
    };
  };
}