{
  lib,
  config,
  ...
}: let
  cfg = config.shell.zsh;
in {
  options.shell.zsh.enable = lib.mkEnableOption "Zsh shell";

  config = lib.mkIf cfg.enable {
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
      initContent = let
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

          # nodejs
          export PNPM_HOME="$HOME/.pnpm"
          PATH="$PNPM_HOME:$PATH"

          # usr
          PATH="$HOME/.local/bin:$PATH"
          # PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

          # go
          PATH=$HOME/go/bin:$PATH

          # rust
          export RUSTPATH="$HOME/.cargo/bin"
          PATH="$RUSTPATH:$PATH"
        '';
        afterContent = lib.mkOrder 1000 "";
      in
        lib.mkMerge [earlyInit beforeCompInit content afterContent];

      shellAliases = {
        reload = "source ~/.config/zsh/.zshrc";
        # system
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        rm = "echo \"This is not the command you are looking for.\"; false";
        sys = "systemctl";
        syss = "systemctl status";
        sysu = "systemctl --user";
        sysus = "systemctl --user status";
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

    programs.eza.enableZshIntegration = true;
    programs.zoxide.enableZshIntegration = true;
    programs.fzf.enableZshIntegration = true;
    programs.direnv.enableZshIntegration = true;
    programs.yazi.enableZshIntegration = true;
  };
}
