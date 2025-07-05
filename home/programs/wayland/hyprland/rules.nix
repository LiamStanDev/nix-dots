{
  # see: https://wiki.hyprland.org/Configuring/Window-Rules/#static-rules
  windowrule = [
    # float by default
    "float, class:.*"

    # window type
    "pseudo, class:fcitx, title:fcitx"
    "tile, class:code" # vscode
    "tile, class:Code" # vscode(flatpak)
    # "tile, class:org.wezfurlong.wezterm"
    "tile, class:google-chrome"
    "tile, class:^zen.*$"
    "float, class:^zen.*$, title:Library"
    "tile, class:obsidian"
    "fullscreen, title:^.* on QEMU/KVM$"
    "fullscreen, class:^steam_app.*$"

    # size
    "size 800 500, class:foot, title:btop"
    "size 600 500, class:foot, title:btm"
    "size 600 500, class:foot, title:nmtui"
    "size 600 500, class:org.pulseaudio.pavucontrol"

    # move
    # "move 1320 50, class:foot, title:btop"
    # "move 1320 50, class:foot, title:btm"
    "move 1320 50, class:foot, title:nmtui"
    "move 1320 50, class:org.pulseaudio.pavucontrol"

    # workspace
    "workspace 2, class:^zen.*$" # Browser
    "workspace 4, class:Spotify" # Misc
    "workspace 8, class:steam" # Gaming
    "workspace 9, title:^.* on QEMU/KVM$" # Virtual Machine

    # effect
    "opacity 1.0, class:google-chrome"

    # idle inhibit
    "idleinhibit fullscreen, class:.*"
  ];
}
