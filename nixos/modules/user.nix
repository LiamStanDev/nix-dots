{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.liam = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "video" "networkmanager" "libvirtd" "liam" ];
    };


    groups = {
      docker = {
        members = [ "liam" ];
      };
    };
  };
}
