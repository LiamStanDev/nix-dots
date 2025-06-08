{
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  networking.hostName = "vivo";

  boot.kernelModules = [ "kvm-intel" ];

  services = {
    # keep SSDs, NVMe healthy and performant
    fstrim.enable = true;
  };
}
