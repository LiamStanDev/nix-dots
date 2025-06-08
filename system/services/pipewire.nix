{ lib, ... }: {
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  services.pulseaudio.enable = lib.mkForce false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
}
