{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5; # only show 5 entries in the boot menu
  boot.loader.timeout = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.initrd.kernelModules = [ "amdgpu" ];
  # boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
}
