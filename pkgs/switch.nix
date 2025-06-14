{
  self,
  pkgs,
}: {
  type = "app";
  program = let
    switch = pkgs.writeShellApplication {
      name = "switch";
      text = ''
        set -eu

          if [ $# -lt 1 ]; then
            echo "Usage: $0 <host> [switch-to-configuration args...]"
            exit 1
          fi

          HOST="$1"
          shift
        nom build --verbose --keep-going --out-link /tmp/generation "${self}#nixosConfigurations.$HOST.config.system.build.toplevel"
        /tmp/generation/bin/switch-to-configuration switch

        echo "NixOS switched successfully."
      '';
      runtimeInputs = [pkgs.nix-output-monitor];
    };
  in "${switch}/bin/switch";
}
