{
  description = "Nixos and Home-Manager Flake";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # System type and master name
    system = "x86_64-linux";
    wheelUser = "liam";

    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # Import NixOS configurations from the hosts directory
    nixosConfigurations = import ./hosts {inherit self inputs wheelUser;};

    # Custom switch as replacement of 'nixos-rebuild switch'
    apps.${system}.switch = import ./pkgs/switch.nix {
      inherit self pkgs;
    };
  };

  inputs = {
    # Nixpkgs input
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager input
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix index for nix-local command
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Run unpatched dynamic binaries on NixOS
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # Secret management
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Widget
    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";
  };
}
