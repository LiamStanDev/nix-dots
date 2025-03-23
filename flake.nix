{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

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
                # set -e
                nom build --verbose --keep-going --out-link generation ${self}#homeConfigurations.profile.activationPackage
                ./generation/activate
              '';
              runtimeInputs = [ pkgs.nix-output-monitor ];
            };
          in
          "${switch-home}/bin/switch-home";
      };
    };
}
