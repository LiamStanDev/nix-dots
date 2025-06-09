{ self, ... }:

let
  # Path to the system module directory
  mod = "${self}/system";
  # Import the 'laptop' module from the system directory
  inherit (import mod) laptop;
in
{
  # Import base laptop modules and additional configuration files
  imports = laptop ++ [
    ./hardware-configuration.nix
    # ./disko.nix

    "${mod}/network"
    "${mod}/network/avahi.nix"
    # "${mod}/network/iptables.nix"
    "${mod}/network/spotify.nix"
  ];

  # Set the hostname for this machine
  networking. hostName = "vivo";

  # Boot configuration
  # initial ramdisk settings
  boot.initrd = {
    systemd. enable = true;
    supportedFilesystems = [ "btrfs" ];
  };
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];

  services = {
    # Enable fstrim service to keep SSDs and NVMe drives healthy
    fstrim.enable = true;
  };
}
