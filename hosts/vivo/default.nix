{
  self,
  inputs,
  host,
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
in {
  # Import base laptop modules and additional configuration files
  imports =
    laptop
    ++ [
      # Hardware
      ./hardware-configuration.nix

      # System
      "${self}/system/hardware/video/intel.nix"
      "${self}/system/network"
      "${self}/system/network/avahi.nix"
      "${self}/system/network/spotify.nix"
      "${self}/system/virt"

      # Home manager
      {
        home-manager.users.${wheelUser} = "${self}/home/profiles/${host}.nix";
        home-manager.extraSpecialArgs = {inherit self host inputs monitors wheelUser;};
      }
    ];

  # Set the hostname for this machine
  networking. hostName = "vivo";

  # Boot configuration
  # initial ramdisk settings
  boot.initrd.supportedFilesystems = ["btrfs"];
  boot.initrd.kernelModules = ["i915"];
  boot.kernelModules = ["kvm-intel"];

  services = {
    # Enable fstrim service to keep SSDs and NVMe drives healthy
    fstrim.enable = true;
  };
}
