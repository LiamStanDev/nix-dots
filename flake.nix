{
  description = "Liam's Nixos and Home-Manager Flake";

  outputs = { flake-parts, ... } @inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ ./hosts ];
    };


  # let
  #   system = "x86_64-linux";
  #   pkgs-stable = import nixpkgs-stable
  #     {
  #       inherit system;
  #       config.allowUnfree = true;
  #     };
  #   pkgs = nixpkgs.legacyPackages.${system};
  #
  #
  #   apps = import ./apps.nix {
  #     inherit pkgs system self host profile;
  #   };
  #
  #   host = "laptop";
  #   profile = "profile";
  # in
  # {
  #   # Nixos
  #   nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
  #     specialArgs = {
  #       inherit pkgs-stable inputs system host profile;
  #     };
  #     modules = [
  #       ./system/configuration.nix
  #     ];
  #   };
  #
  #   # Home manager
  #   homeConfigurations.${profile} = home-manager.lib.homeManagerConfiguration {
  #     inherit pkgs;
  #
  #     extraSpecialArgs = {
  #       inherit pkgs-stable inputs system host profile;
  #     };
  #     modules = [ ./home/home.nix ];
  #   };
  #
  #   apps.${system} = apps;
  # };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi.url = "github:sxyazi/yazi";
  };
}
