{
  self,
  pkgs,
  monitors,
  ...
}: {
  monitor = monitors;

  env = [
    # XDG Specifications
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_DESKTOP,Hyprland"

    # Qt variables
    "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

    # Fcitx5 variables
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
    "coolercontrol"
  ];

  # Execute every reload
  exec = [
    "${pkgs.swww}/bin/swww img ${(import "${self}/home/specializations.nix").wallpaper}"
    # Note: not use 'systemctl --user start fcitx5.service' (see: nixos wiki)
    "fcitx5 -r"
    "hyprpanel -q; hyprpanel"
  ];

  debug = {
    disable_logs = false;
    enable_stdout_logs = true;
  };

  input = {
    kb_layout = "us";
    kb_options = "caps:escape";

    follow_mouse = 0;

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
    gaps_in = 3;
    gaps_out = "1, 6, 6, 6";

    border_size = 2;
    no_border_on_floating = false;
    resize_on_border = true;

    "col.active_border" = "0xFFFFC87F";

    layout = "dwindle";
  };

  decoration = {
    rounding = 0;

    # Opacity
    active_opacity = 1;
    inactive_opacity = 1;

    blur = {
      enabled = true;
      size = 3;
      passes = 3;
      vibrancy = 0.1696;
    };
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

  # see: https://wiki.hypr.land/Configuring/Dwindle-Layout/
  dwindle = {
    pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true; # You probably want this
    force_split = 0;
  };

  misc = {
    animate_manual_resizes = true;
    animate_mouse_windowdragging = true;
    enable_swallow = true;
    render_ahead_of_time = false;
    disable_hyprland_logo = true;
    focus_on_activate = true;
    force_default_wallpaper = -1;
  };
}
