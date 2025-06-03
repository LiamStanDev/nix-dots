{
  description = "My Nixos Configuration";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
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

      host = "laptop";
      profile = "profile";
    in
    {
      # Nixos
      nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit pkgs-stable inputs system ;
        };
        modules = [
          ./nixos/configuration.nix
        ];
      };

      # Home manager
      homeConfigurations.${profile} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ];
      };

      apps.${system}.switch-home = {
        type = "app";
        program =
          let
            switch-home = pkgs.writeShellApplication {
              name = "switch-home";
              text = ''
                set -e

                # Generate timestamp for backup
                TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

                # Set backup environment variable with timestamp
                export HOME_MANAGER_BACKUP_EXT="bckp-$TIMESTAMP"
                nom build --verbose --keep-going --out-link generation ${self}#homeConfigurations.${profile}.activationPackage

                # Activate
                ./generation/activate

                echo "Activated successfully. Backups (if any) created with extension .$HOME_MANAGER_BACKUP_EXT"
              '';
              runtimeInputs = [ pkgs.nix-output-monitor ];
            };
          in
          "${switch-home}/bin/switch-home";
      };
    };
}
