{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprpanel
    bluez
    bluez-tools
    gvfs
    wf-recorder # screen record
    btop
    hyprpicker
    hyprsunset
    brightnessctl
    gpustat
  ];

  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    # Enable the module.
    # Default: false
    enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # https://hyprpanel.com/configuration/settings.html
    settings = {
      layout = {
        # see: https://hyprpanel.com/configuration/modules.html
        "bar.layouts" = {
          "0" = {
            left = ["dashboard" "workspaces" "windowtitle" "cpu" "cputemp" "ram" "cava"];
            middle = ["media"];
            right = ["volume" "network" "bluetooth" "battery" "systray" "clock" "hypridle" "notifications" "power"];
          };
          "1" = {
            left = ["dashboard" "workspaces" "windowtitle" "cpu" "cputemp" "ram" "cava"];
            middle = ["media"];
            right = ["volume" "network" "bluetooth" "battery" "systray" "clock" "hypridle" "notifications" "power"];
          };
          "2" = {
            left = ["dashboard" "workspaces" "windowtitle"];
            middle = ["media"];
            right = ["volume" "clock" "notifications"];
          };
        };
      };

      # bar
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;
      bar.clock.format = "%a %b %d  %I:%M %p";

      # memu
      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      # theme
      theme.bar.transparent = false;
      theme.font = {
        # name = "CaskaydiaCove NF";
        name = "CaskaydiaMono NFM";
        size = "16px";
      };
    };
  };
}
