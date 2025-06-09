{ self, inputs, ... }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = { inherit self inputs; };
in
{
  vivo = nixosSystem {
    inherit specialArgs;
    modules = [
      ./vivo
      ../system/home-manager.nix
      {
        home-manager.users.liam = ../home;
        home-manager.extraSpecialArgs = { inherit inputs; };
      }
    ];
  };
}

