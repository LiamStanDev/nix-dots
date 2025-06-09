{ self, pkgs, host }:

{
  type = "app";
  program =
    let
      switch = pkgs.writeShellApplication {
        name = "switch";
        text = ''
          set -eu

          nom build --verbose --keep-going --out-link /tmp/generation-os "${self}#nixosConfigurations.${host}.config.system.build.toplevel"
          /tmp/generation/bin/switch-to-configuration switch

          echo "NixOS switched successfully."
        '';
        runtimeInputs = [ pkgs.nix-output-monitor ];
      };
    in
    "${switch}/bin/switch";
}
