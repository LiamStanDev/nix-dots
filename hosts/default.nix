# This file auto-discovers host directories and generates a NixOS system
# configuration for each, enabling multi-host management from one place.
{
  self,
  inputs,
  wheelUser,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs) nix-index-database; # nix locate
  inherit (inputs) sops-nix; # sops

  # Get all hosts directory contents
  dirContent = builtins.readDir ./.;

  # Filter directories with default.nix inside
  hostList =
    builtins.filter
    (name: dirContent.${name} == "directory" && builtins.pathExists ./${name}/default.nix)
    (builtins.attrNames dirContent);
in
  builtins.listToAttrs (map (host: {
      name = host;
      value = nixosSystem {
        specialArgs = {inherit self inputs host wheelUser;};
        modules = [
          nix-index-database.nixosModules.nix-index
          sops-nix.nixosModules.sops
          {
            sops.defaultSopsFile = "./secrets/secrets.yaml";
            sops.defaultSopsFormat = "yaml";
            sops.age.keyFile = "/home/${wheelUser}/.config/sops/age/keys.txt";
          }
          ../system/home-manager.nix
          ./${host}
        ];
      };
    })
    hostList)
