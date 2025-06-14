{
  self,
  inputs,
  host,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs) nix-index-database;
in {
  ${host} = nixosSystem {
    specialArgs = {inherit self inputs;};
    modules = [
      nix-index-database.nixosModules.nix-index
      ./${host}
      ../system/home-manager.nix
      {
        home-manager.users.liam = ../home/profiles/${host}.nix;
        home-manager.extraSpecialArgs = {inherit self inputs;};
      }
    ];
  };
}
