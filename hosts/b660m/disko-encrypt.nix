let
  # Common LUKS settings for both disks
  luksSettings = {
    allowDiscards = true;
    keyFile = "/boot/secret.key"; # Same key for both devices, must be on persistent unencrypted partition
  };
in {
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            swap = {
              size = "8G";
              content = {
                type = "swap";
                resumeDevice = true; # allow hibernation
              };
            };
            cryptroot0 = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot0";
                settings = luksSettings;
              };
            };
          };
        };
      };
      disk1 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            cryptroot1 = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot1";
                settings = luksSettings;
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-d"
                    "raid0"
                    "/dev/mapper/cryptroot0"
                  ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime" "ssd"];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                    };
                    "@var" = {
                      mountpoint = "/var";
                      mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                    };
                    "@tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = ["noatime" "nosuid" "nodev" "noexec"];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
