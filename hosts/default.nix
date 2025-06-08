{ self
, inputs
, ...
}: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;

      homeImports = import "${self}/home/profiles";

      mod = "${self}/system";
      # get the basic config to build on top of
      inherit (import mod) laptop;

      # get these into the module system
      specialArgs = { inherit inputs self; };
    in
    {
      vivo = nixosSystem {
        inherit specialArgs;
        modules =
          laptop
          ++ [
            ./vivo

            {
              home-manager = {
                users.liam.imports = homeImports."liam@vivo";
                extraSpecialArgs = specialArgs;
                backupFileExtension = ".hm-backup";
              };
            }
          ];
      };
    };
}
