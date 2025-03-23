{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      nix-output-monitor
      zsh
      babelfish # translate bash to fish
      openssh
      trashy
      neovim
      delta
      cacert # for $SSL_CERT_FILE not found error
      wget
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
      httpie
      speedtest-cli
      stow
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
