# nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix
{
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            # EFI system partition
            ESP = {
              size = "512M";
              type = "EF00"; # UEFI
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
                resumeDevice = true;
              };
            };
            raid = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "md0";
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
            raid = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "md0";
              };
            };
          };
        };
      };
    };

    mdadm.md0 = {
      type = "mdadm";
      level = 0;
      content = {
        type = "gpt";
        partitions = {
          primary = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "@root" = {
                  mountpoint = "/";
                  mountOptions = ["compress=zstd" "noatime" "ssd"];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime" "ssd"];
                };
                "@var" = {
                  mountpoint = "/var";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
                "@tmp" = {
                  mountpoint = "/tmp";
                  mountOptions = ["noatime" "ssd" "noexec"];
                };
              };
            };
          };
        };
      };
    };
  };
}
