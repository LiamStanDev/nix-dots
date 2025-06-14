{
  self,
  host,
  inputs,
  ...
}: let
  # Import the 'laptop' module from the system directory
  inherit (import "${self}/system") desktop;

  monitors = [
    # home monitor
    "desc:ASUSTek COMPUTER INC VG27A N8LMQS004677, 2560x1440, 0x0, 1"
    "desc:LG Electronics LG HDR 4K 0x000641E,3840x2160,2560x0,1.5"
  ];
in {
  # Import base laptop modules and additional configuration files
  imports =
    desktop
    ++ [
      # Hardware
      ./hardware-configuration.nix

      # System
      "${self}/system/hardware/nvidia.nix"
      "${self}/system/network"
      "${self}/system/network/avahi.nix"
      "${self}/system/network/spotify.nix"
      "${self}/system/virt"

      # Home manager
      {
        home-manager.users.liam = "${self}/home/profiles/${host}.nix";
        home-manager.extraSpecialArgs = {inherit self host inputs monitors;};
      }
    ];

  # Set the hostname for this machine
  networking.hostName = "b660m";

  # Boot configuration
  # initial ramdisk settings
  boot.initrd.supportedFilesystems = ["btrfs"];
  # boot.initrd.kernelModules = ["i915" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  boot.kernelModules = ["kvm-intel"];
  boot.kernelParams = ["nvidia_drm.modeset=1"];

  services = {
    # Enable fstrim service to keep SSDs and NVMe drives healthy
    fstrim.enable = true;
  };

  environment.sessionVariables = {
    LIBVA_DIRVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAM = "nvidia";
  };
}
