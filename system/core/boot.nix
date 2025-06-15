{
  pkgs,
  config,
  ...
}: {
  boot = {
    bootspec.enable = true;

    # Kernel version
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "splash" # show animation on boot
      "logo.nologo" # don't show nix logo
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3" # ramdisk udev log level
      "udev.log_priority=3"
    ];

    # initial ramdisk settings
    initrd.systemd.enable = true;

    # Bootloader
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = null;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
        theme = "${(pkgs.catppuccin-grub.override {flavor = "frappe";})}";
      };
    };

    # Boot animation
    plymouth = {
      enable = true;
      theme = "catppuccin-frappe";

      themePackages = with pkgs; [
        (catppuccin-plymouth.override {variant = "frappe";})
      ];
    };
  };

  # Filesystem support
  boot.supportedFilesystems = ["ntfs" "exfat" "ext4" "fat32" "btrfs"];
  services.devmon.enable = true; # automatic device mounting daemon
  services.gvfs.enable = true; # userspace virtual filesystem
  services.udisks2.enable = true; # DBus service that allows applications to query and manipulate storage devices

  environment.systemPackages = [
    config.boot.kernelPackages.cpupower
  ];
}
