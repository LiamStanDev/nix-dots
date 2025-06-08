{
  imports = [
    ./backlight.nix
    ./pipewire.nix
    ./power.nix
  ];

  services = {
    # faster dbus implementation
    dbus.implementation = "broker";

    # Syncs browser profile dirs to RAM
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}
