{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # EFI system partition
            ESP = {
              label = "boot";
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
              size = "16G";
              label = "swap";
              content = {
                type = "swap";
                resumeDevice = true; # allow hibernation
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd"];
                  };
                  "/var" = {
                    mountpoint = "/var";
                    mountOptions = ["compress=zstd:1"];
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
