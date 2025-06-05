{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs"; # if you use btrfs
    };


    # see: https://wiki.nixos.org/wiki/Libvirt
    libvirtd = {
      enable = true;
    };
  };
}
