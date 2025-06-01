{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # Don't install trash-cli in nixpkgs (completion not work)
      nix-output-monitor
      zsh
      babelfish # translate bash to fish
      openssh
      neovim
      delta
      unzip
      bat
      zellij # rust replacement of tmux
      bottom # rust replacement of top
      tealdeer # rust replacement of tldr
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
      # WARN: don't add c/c++ build tool here. The build path is wierd.
      # (hiPrio gcc) # set high priority because of clang
      # clang
      # cmake
      # ninja
      nodejs_22
      bun
      deno
      pnpm
      lldb
      go
      uv
      kubectl

      # fonts
      nerd-fonts.caskaydia-mono
      nerd-fonts.jetbrains-mono
      fira-sans
      font-awesome
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      roboto

      # desktop environment
      # wezterm # WARN: don't use it. use system provide version.
      # swaylock-effects # WARN: can't access PAM
    ];
}
