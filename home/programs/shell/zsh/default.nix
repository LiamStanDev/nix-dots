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
        sysu = "systemctl --user";
        sysj = "journalctl --no-pager";
        cp = "cp --interactive";
        mv = "mv --interactive";
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

        # rg
        rg = "rg --hidden --smart-case --glob='!.git/' --no-search-zip --trim --colors=line:fg:black --colors=line:style:bold --colors=path:fg:magenta --colors=match:style:nobold";

        # edit
        e = "$EDITOR";
        E = "sudo -e";

        # lazy
        lzg = "lazygit";
        lzd = "lazydocker";

        # nodejs
        pn = "pnpm";

        # git
        gl = "git log --graph --all --pretty=format:\"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n\"";
        gs = "git status --short";

        ga = "git add";
        gap = "git add --patch";

        gd = "git diff --output-indicator-new=' ' --output-indicator-old=' '";
        gds = "gd --staged";

        gc = "git commit";
        gca = "gc --amend --no-edit";
        gce = "gc --amend";

        gu = "git pull";
        gp = "git push";

        gt = "git stash";
        gtp = "git stash pop";

        # docker
        dps = "docker ps --format \"table {{.Names}}\t{{.Status}}\t{{.Ports}}\"";
        dl = "docker logs --tail=100";
        dc = "docker compose";
      };
    };

    programs.eza.enableZshIntegration = true;
    programs.zoxide.enableZshIntegration = true;
    programs.fzf.enableZshIntegration = true;
    programs.direnv.enableZshIntegration = true;
    programs.yazi.enableZshIntegration = true;
  };
}
