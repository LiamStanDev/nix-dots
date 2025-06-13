{self, ...}: let
  # Import the 'laptop' module from the system directory
  inherit (import "${self}/system") laptop;
in {
  # Import base laptop modules and additional configuration files
  imports =
    laptop
    ++ [
      ./hardware-configuration.nix
      # ./disko.nix

      "${self}/system/network"
      "${self}/system/network/avahi.nix"
      "${self}/system/network/spotify.nix"
      "${self}/system/virt"
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
