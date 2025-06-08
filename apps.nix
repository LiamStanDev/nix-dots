{ pkgs, system, self, host, profile }:

{
  switch-os = {
    type = "app";
    program =
      let
        switch-os = pkgs.writeShellApplication {
          name = "switch-os";
          text = ''
            set -eu

            nom build --verbose --keep-going --out-link /tmp/generation-os "${self}#nixosConfigurations.${host}.config.system.build.toplevel"
            /tmp/generation-os/bin/switch-to-configuration switch

            echo "NixOS switched successfully."
          '';
          runtimeInputs = [ pkgs.nix-output-monitor pkgs.nix ];
        };
      in
      "${switch-os}/bin/switch-os";
  };

  switch-home = {
    type = "app";
    program =
      let
        switch-home = pkgs.writeShellApplication {
          name = "switch-home";
          text = ''
            set -eu

            timestamp=$(date +%Y-%m-%d-%H-%M-%S)
            export HOME_MANAGER_BACKUP_EXT="bckp-$timestamp"

            nom build --verbose --keep-going --out-link /tmp/generation-hm "${self}#homeConfigurations.${profile}.activationPackage"
            /tmp/generation-hm/activate

            echo "Home successfully. Backups (if any) created with extension .$HOME_MANAGER_BACKUP_EXT"
          '';
          runtimeInputs = [ pkgs.nix-output-monitor pkgs.nix ];
        };
      in
      "${switch-home}/bin/switch-home";
  };
}
