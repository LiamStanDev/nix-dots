{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs;
    [
      zsh
      neovim
      delta
      unzip
      bat
      zellij # rust replacement of tmux
      bottom # rust replacement of top
      tealdeer # rust replacement of tldr
      cacert # for $SSL_CERT_FILE not found error
      chafa # terminal image previewer
      lazygit
      lazydocker
      direnv
      httpie
      starship
      eza
      fzf
      yazi
      zoxide
      trash-cli

      # libs
      python313

      # theme
      (catppuccin-kvantum.override {
        accent = "blue";
        variant = "macchiato";
      })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      papirus-folders
    ];
}
