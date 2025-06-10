{
  self,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.nix-index-database.nixosModules) nix-index-db;
  specialArgs = {inherit self inputs;};
in {
  vivo = nixosSystem {
    inherit specialArgs;
    modules = [
      nix-index-db.nix-index
      ./vivo
      ../system/home-manager.nix
      {
        home-manager.users.liam = ../home;
        home-manager.extraSpecialArgs = {inherit inputs;};
      }
    ];
  };
}
