{pkgs, ...}: {
  # battery information
  services.upower.enable = true;

  # powerkey handling
  services.logind.powerKey = "suspend";

  services.power-profiles-daemon.enable = false; # conflict with auto-cpufreq
  services.auto-cpufreq.enable = true; # energy save(auto) for laptop
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
  ];
}
