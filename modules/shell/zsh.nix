{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    envExtra = ''
      # nix
      if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi
    '';
    initContent =
      let
        earlyInit = lib.mkOrder 500 ''
          ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
          [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
          [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
          source "''${ZINIT_HOME}/zinit.zsh"
        '';
        beforeCompInit = lib.mkOrder 550 ''
          # completions
          FPATH="$HOME/.zfunc:$FPATH"
          zi light "zsh-users/zsh-completions"
        '';
        content = lib.mkOrder 1000 ''
          # plugins
          zi light "zsh-users/zsh-history-substring-search"
          zi light "zsh-users/zsh-autosuggestions"
          zi light "zdharma/fast-syntax-highlighting"
          zi light "hlissner/zsh-autopair"
          zi light "jeffreytse/zsh-vi-mode"
          zi light "Aloxaf/fzf-tab"

          # environment
          export EDITOR=nvim visudo
          export VISUAL=nvim visudo
          export SUDO_EDITOR=nvim
          export BROWSER=google-chrome
          if [[ "$DESKTOP_SESSION" == "niri" ]]; then
              # vscode for wayland
              alias code="code --ozone-platform-hint=auto --enable-wayland-ime --wayland-text-input-version=3"
          fi

          # nodejs
          export PNPM_HOME="$HOME/.pnpm"
          PATH="$PNPM_HOME:$PATH"
          
          # usr
          PATH="$HOME/.local/bin:$PATH"
          PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

          # go
          PATH=$HOME/go/bin:$PATH
          
          # rust
          export RUSTPATH="$HOME/.cargo/bin"
          PATH="$RUSTPATH:$PATH"

        '';
        afterContent = lib.mkOrder 1000 "";
      in

      lib.mkMerge [ earlyInit beforeCompInit content afterContent ];

    shellAliases = {
      reload = "source ~/.config/zsh/.zshrc";
      # system
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      rm = "echo \"This is not the command you are looking for.\"; false";
      sys = "systemctl";
      mkdir = "mkdir -p";
      c = "clear";
      poweroff = "systemctl poweroff";
      reboot = "systemctl reboot";

      # Colorize grep output
      grep = "grep --color=auto";

      # ls
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      lR = "eza -lR";

      # cd
      cd = "z";

      # trash-cli
      t = "trash-put";

      # vim and neovim
      v = "vim";
      n = "nvim";
      nv = "nvim";

      # lazy
      lzg = "lazygit";
      lzd = "lazydocker";

      # nodejs
      pn = "pnpm";

      # git
      gl = "git log --graph --decorate --pretty=oneline --abbrev-commit --all";
      gC = "git commit";
      gP = "git publish";
      ga = "git add .";
      gc = "git commit -m";
      gca = "git commit -am";
      gd = "git diff";
      gdm = "git diff master";
      gp = "git pull";
      gs = "git status --short --branch --renames";
      gt = "git stash";
      gtp = "git stash pop";
    };
  };
}
