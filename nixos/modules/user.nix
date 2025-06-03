{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.liam = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "networkmanager" "libvirtd" ];
    };
  };
}
