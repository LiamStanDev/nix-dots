{
  pkgs,
  wheelUser,
  ...
}: {
  environment.systemPackages = with pkgs; [
    looking-glass-client
  ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/scream 0660 ${wheelUser} qemu-libvirtd -"
    "f /dev/shm/looking-glass 0660 ${wheelUser} qemu-libvirtd -"
  ];
}
