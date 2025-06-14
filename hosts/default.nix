{
  self,
  inputs,
  host,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs) nix-index-database;
in {
  default = nixosSystem {
    specialArgs = {inherit self host inputs;};
    modules = [
      nix-index-database.nixosModules.nix-index
      ../system/home-manager.nix
      ./${host}
    ];
  };
}
