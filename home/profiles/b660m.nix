{
  imports = [
    ./.

    ../programs
  ];

  shell.zsh.enable = true;
  emulators.ghostty.enable = true;
  emulators.foot.enable = true;

  wayland.hypr.enable = true;
  wayland.hypridle.enable = true;
  sync.enable = true;
}
