{
  services.power-profiles-daemon.enable = false;
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

  services.thermald.enable = true;
}
