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
            left = ["dashboard" "workspaces" "windowtitle" "cpu" "cputemp" "ram" "systray"];
            middle = ["media"];
            right = ["volume" "network" "bluetooth" "battery" "clock" "hypridle" "notifications" "power"];
          };
          "1" = {
            left = ["dashboard" "workspaces" "windowtitle" "cpu" "cputemp" "ram" "systray"];
            middle = ["media"];
            right = ["volume" "network" "bluetooth" "battery" "clock" "hypridle" "notifications" "power"];
          };
        };
      };

      # bar
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = false;
      bar.clock.format = "%I:%M %p";

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

      # notification
      notifications.position = "top right";

      # theme
      theme.bar.transparent = true;
      theme.bar.floating = false;
      theme.bar.location = "top";
      theme.bar.margin_bottom = "0em";
      theme.bar.margin_sides = "0.5em";
      theme.bar.margin_top = "0.5em";
      theme.font = {
        # name = "CaskaydiaCove NF";
        name = "CaskaydiaMono NFM";
        size = "16px";
      };
    };
  };
}
