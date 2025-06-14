{
  self,
  pkgs,
  ...
}: let
  monitors = [
    # display name, resolution, position, scale

    # builtin monitor
    "desc:Samsung Display Corp. 0x4161, 1920x1080, 0x0, 1"

    # home monitor
    "desc:ASUSTek COMPUTER INC VG27A N8LMQS004677, 2560x1440, 0x0, 1"
    "desc:LG Electronics LG HDR 4K 0x000641E,3840x2160,2560x0,1.5"

    # work monitor
    "desc:Acer Technologies Acer V246HL LXMTT0104229, 1920x1080, 1920x0, 1"
  ];

  # Screenshot
  screenshot = import "${self}/pkgs/screenshot.nix" {inherit pkgs;};
  # swayosd = import "${self}/pkgs/swayosd-hyprland.nix" {inherit pkgs;};
in {
  wayland.windowManager.hyprland = {
    enable = true; # also enable hyprland-protocols
    xwayland.enable = true;
    systemd.variables = ["--all"]; # add $PATH to systemd
    systemd.enable = true; # enable hyprland-session.target

    settings = {
      "$mainMod" = "SUPER";

      monitor = monitors;

      env = [
        # XDG Specifications
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        # "XDG_SCREENSHOTS_DIR,~/Pictures/screens"

        # Qt variables
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        # Fcitx5 variables
        #"GTK_IM_MODULE,fcitx" # no need
        "QT_IM_MODULES,wayland;fcitx;ibus"
        "XMODIFIERS,@im=fcitx" # for XWayland
        "SDL_IM_MODULE,fcitx" # for SDL library gaming
        "GLFW_IM_MODULE,ibus" # for kitty terminal
      ];

      # Execute only when launch
      exec-once = [
        "${pkgs.swww}/bin/swww img ${(import "${self}/home/specializations.nix").wallpaper}"
        # Note: not use 'systemctl --user start fcitx5.service' (see: nixos wiki)
        "fcitx5 -r"
      ];

      # Execute every reload
      exec = [
        "${pkgs.swww}/bin/swww img ${(import "${self}/home/specializations.nix").wallpaper}"
        # Note: not use 'systemctl --user start fcitx5.service' (see: nixos wiki)
        "fcitx5 -r"
        "systemctl --user restart waybar.service"
      ];

      bind = [
        # System
        "$mainMod, Q, killactive,"
        "$mainMod, R, exec, hyprctl reload,"
        "$mainMod SHIFT, Q, exec, pkill ${pkgs.rofi}/bin/rofi || exec ~/.config/rofi/scripts/powermenu_t3"

        # Screenshot
        "$mainMod, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\""

        # Layout
        "$mainMod, M, fullscreen,"
        "$mainMod, F, togglefloating,"
        "$mainMod CTRL, V, togglesplit,"

        # Move focus
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, TAB, exec, source ~/.config/hypr/scripts/changefocus.sh"

        # Move window
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Resize
        "$mainMod CTRL, h, resizeactive, -80 0"
        "$mainMod CTRL, l, resizeactive, 80 0"
        "$mainMod CTRL, k, resizeactive, 0 -40"
        "$mainMod CTRL, j, resizeactive, 0 40"

        # Workspace switching
        "$mainMod SHIFT, TAB, workspace, m+1"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Launch apps
        "$mainMod, RETURN, exec, [float;tile] ${pkgs.wezterm}/bin/wezterm start --always-new-process"
        "$mainMod, SPACE, exec, pkill ${pkgs.rofi}/bin/rofi || exec ~/.config/rofi/scripts/launcher_t6"
        "$mainMod, E, exec, ${pkgs.nautilus}/bin/nautilus"
        "$mainMod, T, exec, pkill kitty || ${pkgs.kitty}/bin/kitty -e btm"
        "$mainMod, B, exec, google-chrome-stable"
        "$mainMod, P, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"
        "$mainMod, S, exec, ${screenshot.program}"
        "$mainMod SHIFT, S, exec, ${screenshot.program} --save"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # l: lock can use
      bindl = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          middle_button_emulation = true;
          tap-to-click = true;
          scroll_factor = 0.2;
          drag_lock = true;
          tap_button_map = "lrmr";
        };

        repeat_rate = 50;
        repeat_delay = 200;
        sensitivity = 0.5;
        accel_profile = "adaptive";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_invert = true;
        workspace_swipe_distance = 600;
        workspace_swipe_forever = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        no_border_on_floating = true;
        border_size = 2;
        "col.active_border" = "0xFFFFC87F";
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;

        # Opacity
        active_opacity = 0.95;
        inactive_opacity = 0.95;

        # blur = {
        #   enabled = true;
        #   size = 16;
        #   passes = 2;
        #   new_optimizations = true;
        # };
      };

      animations = {
        enabled = true;

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
      };

      # see: https://wiki.hyprland.org/Configuring/Window-Rules/#static-rules
      windowrule = [
        # float by default
        "float, class:.*"

        # window type
        "pseudo, class:fcitx, title:fcitx"
        "tile, class:code" # vscode
        "tile, class:org.wezfurlong.wezterm"
        "tile, class:google-chrome"
        "tile, class:obsidian"
        "fullscreen, title:^.* on QEMU/KVM$"

        # size
        "size 600 500, class:kitty, title:kitty"
        "size 600 500, class:kitty, title:btop"
        "size 600 500, class:kitty, title:nmtui"
        "size 600 500, class:org.pulseaudio.pavucontrol"

        # move
        "move 1320 50, class:kitty, title:kitty"
        "move 1320 50, class:kitty, title:btop"
        "move 1320 50, class:kitty, title:nmtui"
        "move 1320 50, class:org.pulseaudio.pavucontrol"

        # effect
        "opacity 1.0, class:google-chrome"
      ];
    };
  };
}
