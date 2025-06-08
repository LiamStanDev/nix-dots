{
  virtualisation = {
    # Docker
    docker.enable = true;
    docker. storageDriver = "btrfs"; # if you use btrfs

    # Virtualization with QEMU/KVM
    # see: https://wiki.nixos.org/wiki/Libvirt
    libvirtd.enable = true;
  };
}
