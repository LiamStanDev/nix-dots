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
      bat
      ripgrep
      cacert # for $SSL_CERT_FILE not found error
      wget
      perf-tools # perf
      sysstat # iostat and pidstat
      ripgrep
      fd
      chafa # terminal image previewer
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
      nodejs_22
      bun
      pnpm
      lldb
      go
      uv
      python313
    ];
}
