{
  imports = [
    ./.

    ../programs
  ];

  shell.zsh.enable = true;
  emulators.ghostty.enable = true;
  emulators.foot.enable = true;
  sync.enable = true;
}
