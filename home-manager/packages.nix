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
    ];
}
