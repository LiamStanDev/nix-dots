{
  self,
  inputs,
  wheelUser,
  ...
}: let
  # Import the 'laptop' module from the system directory
  inherit (import "${self}/system") desktop;

  monitors = [
    # builtin monitor
    ", prefer, 0x0, 1"
  ];

  workspace = [];
in rec {
  # Import base laptop modules and additional configuration files
  imports =
    desktop
    ++ [
      # Disk
      ./disko.nix
      # Hardware
      ./hardware-configuration.nix

      # System
      "${self}/system/hardware/video/intel.nix"
      "${self}/system/network/tailscale.nix"
      "${self}/system/network/avahi.nix"
      "${self}/system/network/spotify.nix"
      "${self}/system/virt"

      # Home manager
      ../../system/home-manager.nix
      {
        home-manager.users.${wheelUser} = "${self}/home/profiles/${networking.hostName}.nix";
        home-manager.extraSpecialArgs = {inherit self inputs wheelUser monitors workspace;};
      }
    ];

  # Set the hostname for this machine
  networking.hostName = "vivo";
}
