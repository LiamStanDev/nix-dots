{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable
        {
          inherit system;
          config.allowUnfree = true;
        };
      pkgs = nixpkgs.legacyPackages.${system};


      apps = import ./apps.nix {
        inherit pkgs system self host profile;
      };

      host = "laptop";
      profile = "profile";
    in
    {
      # Nixos
      nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit pkgs-stable inputs system host profile;
        };
        modules = [
          ./nixos/configuration.nix
        ];
      };

      # Home manager
      homeConfigurations.${profile} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit pkgs-stable inputs system host profile;
        };
        modules = [ ./home-manager/home.nix ];
      };

      apps.${system} = apps;
    };
}
