{
  description = "Nixos and Home-Manager Flake";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    wheelUser = "liam";
  in {
    # Import NixOS configurations from the hosts directory
    nixosConfigurations = import ./hosts {inherit self inputs wheelUser;};
  };

  inputs = {
    # Nixpkgs input
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager input
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Disk parition
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Nix index for nix-local command
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprpanel
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprpanel.inputs.nixpkgs.follows = "nixpkgs";

    # Ghostty
    ghostty.url = "github:ghostty-org/ghostty";
  };
}
