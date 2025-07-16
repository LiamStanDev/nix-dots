{
  pkgs,
  wheelUser,
  ...
}: {
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
    razergenie
  ];

  users.users.${wheelUser} = {extraGroups = ["openrazer"];};
}
