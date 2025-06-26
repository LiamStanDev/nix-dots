{
  self,
  host,
  inputs,
  wheelUser,
  ...
}: let
  # Import the 'laptop' module from the system directory
  inherit (import "${self}/system") desktop;

  monitors = [
    # home monitor
    "desc:ASUSTek COMPUTER INC VG27A N8LMQS004677, 2560x1440, 0x0, 1"
    # "desc:LG Electronics LG HDR 4K 0x000641E,3840x2160,2560x0,1.5"
    "desc:LG Electronics LG HDR 4K 0x000641E, 2560x1440, 2560x0, 1"
  ];
in {
  # Import base laptop modules and additional configuration files
  imports =
    desktop
    ++ [
      # Hardware
      ./hardware-configuration.nix

      # System
      "${self}/system/hardware/video/intel.nix"
      "${self}/system/hardware/video/nvidia.nix"
      "${self}/system/network"
      "${self}/system/network/tailscale.nix"
      "${self}/system/network/avahi.nix"
      "${self}/system/network/spotify.nix"
      "${self}/system/virt"
      # "${self}/system/virt/looking-glass.nix"

      # Home manager
      {
        home-manager.users.${wheelUser} = "${self}/home/profiles/${host}.nix";
        home-manager.extraSpecialArgs = {inherit self host inputs monitors wheelUser;};
      }
    ];

  # Set the hostname for this machine
  networking.hostName = "b660m";

  # Boot configuration
  # initial ramdisk settings
  boot.initrd.supportedFilesystems = ["btrfs"];

  services = {
    # Enable fstrim service to keep SSDs and NVMe drives healthy
    fstrim.enable = true;
  };

  environment.sessionVariables = {
    # These are the defaults, and xdg.enable does set them, but due to load
    # order, they're not set before environment.variables are set, which could
    # cause race conditions.
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";
  };
}
