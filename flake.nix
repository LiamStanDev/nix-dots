{
  description = "Home Manager configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "github:nix-community/home-manager/release-24.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."profile" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
      };

      apps.${system}.switch = {
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
                nom build --verbose --keep-going --out-link generation ${self}#homeConfigurations.profile.activationPackage

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
