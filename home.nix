{ config, pkgs, repoPath, ... }:

{
  home.username = "liam";
  home.homeDirectory = "/home/liam";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
    [
      zsh
      fish
      babelfish # translate bash to fish
      git
      openssh
      neovim
      zoxide
      wget
      starship
      perf-tools # perf
      sysstat # iostat and pidstat
      ripgrep
      fd
      lazygit
      lazydocker
      htop
      btop
      duf
      dust
      eza
      direnv
      netcat
      speedtest-cli
      stow
      yazi
      fastfetch
      (hiPrio gcc) # set high priority because of clang
      clang
      cmake
      ninja
      rustup
      go
      uv
      python313
      nodejs_22
    ];

  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # WARN: Please read the comment before changing.
}
