{
  self,
  inputs,
  wheelUser,
  ...
}: let
  # Import the 'laptop' module from the system directory
  inherit (import "${self}/system") laptop;

  monitors = [
    # builtin monitor
    "desc:Samsung Display Corp. 0x4161, 1920x1080, 0x0, 1"
    # home monitor
    "desc:ASUSTek COMPUTER INC VG27A N8LMQS004677, 2560x1440, 0x-1440, 1"
    # work monitor
    "desc:Acer Technologies Acer V246HL LXMTT0104229, 1920x1080, 1920x0, 1"
  ];
in rec {
  # Import base laptop modules and additional configuration files
  imports =
    laptop
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
      "${self}/system/desktop/flatpak.nix"

      # Home manager
      ../../system/home-manager.nix
      {
        home-manager.users.${wheelUser} = "${self}/home/profiles/${networking.hostName}.nix";
        home-manager.extraSpecialArgs = {inherit self inputs wheelUser monitors;};
      }
    ];

  # Set the hostname for this machine
  networking.hostName = "vivo";

  services = {
    # Enable fstrim service to keep SSDs and NVMe drives healthy
    fstrim.enable = true;
  };
}
