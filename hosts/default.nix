# This file auto-discovers host directories and generates a NixOS system
# configuration for each, enabling multi-host management from one place.
{
  self,
  inputs,
  wheelUser,
  ...
}: let
  # abbreviation
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs) nix-index-database; # nix locate
  inherit (inputs) disko;

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
        system = "x86_64-linux";
        specialArgs = {inherit self inputs host wheelUser;};
        modules = [
          # 3rd party modules
          nix-index-database.nixosModules.nix-index
          disko.nixosModules.disko # Auto scan disko no need filesystem

          # Host configuration
          ./${host}

          # Enviranment Variables
          {
            environment.sessionVariables = {
              # These are the defaults, and xdg.enable does set them, but due to load
              # order, they're not set before environment.variables are set, which could
              # cause race conditions.
              XDG_CACHE_HOME = "$HOME/.cache";
              XDG_CONFIG_HOME = "$HOME/.config";
              XDG_DATA_HOME = "$HOME/.local/share";
              XDG_BIN_HOME = "$HOME/.local/bin";
            };
          }
        ];
      };
    })
    hostList)
