{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      liam = {
        isNormalUser = true;
        extraGroups = [ "input" "video" "networkmanager" ];
      };
    };


    groups = {
      wheel = {
        members = [ "liam" ];
      };
      docker = {
        members = [ "liam" ];
      };
      libvirtd = {
        members = [ "liam" ];
      };
    };
  };
}
