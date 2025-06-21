{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    # experimental has features like battery info for Bluetooth devices
    package = pkgs.bluez5-experimental;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Class = "0x000100"; # 0x000100 = Computer
        ControllerMode = "dual"; # can connect to normal devices and low energy devices (fix mx master not found issue)
        FastConnectable = true;
        JustWorksRepairing = "always";
        Privacy = "device";
        # Battery info for Bluetooth devices
        Experimental = true;
      };
    };
  };

  # https://github.com/NixOS/nixpkgs/issues/114222
  systemd.user.services.telephony_client.enable = false;

  # bluetooth management GUI
  services.blueman.enable = false; # use hyprland bluez instead
}
