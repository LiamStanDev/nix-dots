{ config, pkgs, lib, ... }:

{
  imports = [
    ./bash.nix
    ./fish.nix
  ];

  programs = {
    zoxide.enable = true;
    fzf.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        scan_timeout = 10;
        container.disabled = true;
      };
    };
    yazi.enable = true;
    direnv = {
      enable = true;
      config = {
        direnv_fish_mode = "eval_on_arrow";
      };
    };
    ssh = {
      enable = true;
    };
    gpg.enable = true;
    man.enable = true;
  };
}
