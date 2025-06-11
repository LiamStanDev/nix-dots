{pkgs, ...}: {
  imports = [
    ./docker.nix
    ./libvirt.nix
  ];

  boot.extraModprobeConfig = "options kvm_intel nested=1";
}
