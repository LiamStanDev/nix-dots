{pkgs, ...}: {
  # battery information
  services.upower.enable = true;

  # powerkey handling
  services.logind.powerKey = "suspend";

  services.power-profiles-daemon.enable = true; # conflict with auto-cpufreq
  # services.auto-cpufreq.enable = true; # energy save(auto) for laptop
  # services.auto-cpufreq.settings = {
  #   battery = {
  #     governor = "powersave";
  #     turbo = "never";
  #   };
  #   charger = {
  #     governor = "performance";
  #     turbo = "auto";
  #   };
  # };
}
