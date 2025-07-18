{
  self,
  pkgs,
  ...
}: let
in {
  "$mainMod" = "SUPER";
  bind = [
    # System
    "$mainMod, Q, killactive,"
    "$mainMod, R, exec, hyprctl reload,"
    "$mainMod SHIFT, Q, exec, pkill ${pkgs.rofi}/bin/rofi || exec ~/.config/rofi/scripts/powermenu_t3"

    # Layout
    "$mainMod, M, fullscreen,"
    "$mainMod, F, togglefloating,"
    "$mainMod, V, togglesplit,"
    "$mainMod, P, pseudo,"

    # Move focus
    "$mainMod, h, movefocus, l"
    "$mainMod, l, movefocus, r"
    "$mainMod, k, movefocus, u"
    "$mainMod, j, movefocus, d"
    "$mainMod, TAB, cyclenext," # change focus
    "$mainMod, TAB, bringactivetotop," # and then bring to front

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
    "$mainMod, F1, workspace, 6"
    "$mainMod, F2, workspace, 7"
    "$mainMod, F3, workspace, 8"
    "$mainMod, F4, workspace, 9"
    "$mainMod, F5, workspace, 10"

    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, F1, movetoworkspace, 6"
    "$mainMod SHIFT, F2, movetoworkspace, 7"
    "$mainMod SHIFT, F3, movetoworkspace, 8"
    "$mainMod SHIFT, F4, movetoworkspace, 9"
    "$mainMod SHIFT, F5, movetoworkspace, 10"

    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"

    # Launch apps
    # "$mainMod, RETURN, exec, [float;tile] ${pkgs.wezterm}/bin/wezterm start --always-new-process"
    # "$mainMod, RETURN, exec, [tile] ghostty -e 'tmux attach -t undefined || tmux new -s undefined'"
    "$mainMod, RETURN, exec, [tile] ghostty"
    "$mainMod, SPACE, exec, pkill rofi || exec ~/.config/rofi/scripts/launcher_t6"
    "$mainMod, E, exec, ${pkgs.nautilus}/bin/nautilus"
    "$mainMod, T, exec, pkill foot || ${pkgs.foot}/bin/foot --title=btop -e btop"
    # "$mainMod, B, exec, google-chrome-stable"
    "$mainMod, B, exec, flatpak run app.zen_browser.zen"
    # "$mainMod, P, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"
    "$mainMod, S, exec, screenshot"
    "$mainMod SHIFT, S, exec, screenshot --save"
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
}
