{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    generateCompletions = true;

    shellInit = ''
      if test -f "$HOME/.nix-profile/etc/profile.d/nix.fish"
          source "$HOME/.nix-profile/etc/profile.d/nix.fish"
      end
    '';
    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings
      # selection with vi key bindings
      bind -M insert \cj 'commandline -P; and down-or-search; or commandline -f execute'
      bind -M insert \ck 'commandline -P; and up-or-search'
      bind -M insert \ch 'commandline -P; and commandline -f backward-char; or commandline -f backward-delete-char'
      bind -M insert \cl 'commandline -P; and commandline -f forward-char; or commandline -f clear-screen'
    '';

    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf";
        src = fzf-fish.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
    ];

    functions = {
      b = ''
        echo $argv | babelfish | source
      '';
    };
    shellAbbrs = {
      rm = "trash";
      sys = "systemctl";
      syu = "systemctl --user";

      # grep
      grep = "grep --color=auto";

      # ls with eza
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";

      # vim and neovim
      v = "vim";
      n = "nvim";
      nv = "nvim";

      # lazy tools
      lzg = "lazygit";
      lzd = "lazydocker";

      # python
      p = "python3";
      pm = "python3 -m";

      # Git abbreviations
      gl = "git log --graph --decorate --pretty=oneline --abbrev-commit --all";
      gt = "git stash";
      gtp = "git stash pop";
      gp = "git pull";
      gP = "git publish";
      gc = "git commit -m";
      gca = "git commit -am";
      gC = "git commit";
      gdm = "git diff master";
      gd = "git diff";
      gs = "git status --short --branch --renames";
    };
    shellAliases = {
      mkdir = "mkdir -p";
    };
  };
  programs.fzf.enableFishIntegration = false;
}

