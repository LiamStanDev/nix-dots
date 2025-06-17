{
  config,
  lib,
  ...
}: let
  cfg = config.wayland.hypridle;
in {
  options.wayland.hypridle.enable = lib.mkEnableOption "Hypridle for Hyprland session management";

  config = lib.mkIf cfg.enable {
    services.hypridle.enable = true;

    services.hypridle.settings = {
      general = {
        lock_cmd = "hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "hyprlock";
        }
        {
          timeout = 240;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 540; # 9mins
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
