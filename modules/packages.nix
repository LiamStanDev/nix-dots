{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      zsh
      fish
      babelfish # translate bash to fish
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
}
