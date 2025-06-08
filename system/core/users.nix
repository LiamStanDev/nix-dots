{ pkgs, ... }: {

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.bash;

    users.liam = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "input"
        "video"
        "plugdev" # plugable devices. e.g. USB
        "transmission" # BitTorrent
        "networkmanager"
        "libvirtd"
        "docker"
      ];
    };
  };
}
