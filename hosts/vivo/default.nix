{self, ...}: let
  # Import the 'laptop' module from the system directory
  inherit (import ../../system) laptop;
in {
  # Import base laptop modules and additional configuration files
  imports =
    laptop
    ++ [
      ./hardware-configuration.nix
      # ./disko.nix

      ../../system/network
      ../../system/network/avahi.nix
      # ../../system/network/iptables.nix
      ../../system/network/spotify.nix
    ];

  # Set the hostname for this machine
  networking. hostName = "vivo";

  # Boot configuration
  # initial ramdisk settings
  boot.initrd = {
    systemd. enable = true;
    supportedFilesystems = ["btrfs"];
  };
  boot.initrd.kernelModules = ["i915"];
  boot.kernelModules = ["kvm-intel"];

  services = {
    # Enable fstrim service to keep SSDs and NVMe drives healthy
    fstrim.enable = true;
  };
}
