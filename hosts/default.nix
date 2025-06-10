{
  self,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs) nix-index-database;
in {
  vivo = nixosSystem {
    specialArgs = {inherit self inputs;};
    modules = [
      nix-index-database.nixosModules.nix-index
      ./vivo
      ../system/home-manager.nix
      {
        home-manager.users.liam = ../home;
        home-manager.extraSpecialArgs = {inherit inputs;};
      }
    ];
  };
}
