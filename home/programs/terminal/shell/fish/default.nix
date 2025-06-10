{pkgs, ...}: let
  catppuccin-fish = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "6a85af2ff722ad0f9fbc8424ea0a5c454661dfed"; # commit hash or tag
    hash = "sha256-Oc0emnIUI4LV7QJLs4B2/FQtCFewRFVp7EDv8GawFsA=";
  };
in {
  xdg.configFile."fish/themes/Catppuccin Frappe.theme".source = "${catppuccin-fish}/themes/Catppuccin Frappe.theme";
  programs.fish = {
    enable = true;
    generateCompletions = true;

    shellInit = ''
      if test -f "$HOME/.nix-profile/etc/profile.d/nix.fish"
          source "$HOME/.nix-profile/etc/profile.d/nix.fish"
      end
      fish_add_path -g "$HOME/.local/bin" # local binary
      fish_add_path -g "$HOME/.cargo/bin" # cargo binary path
      fish_add_path -g "$HOME/.local/share/nvim/mason/bin" # fix lsp client not found
    '';
    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings
      fish_config theme choose "Catppuccin Frappe"
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
      lR = "eza -lR";

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
      ga = "git add .";
      gc = "git commit -m";
      gca = "git commit -am";
      gC = "git commit";
      gdm = "git diff master";
      gd = "git diff";
      gs = "git status --short --branch --renames";

      # Docker
      # Print Docker containers in a compact table; ID is shortened, STATUS shows only the first word.
      dps = ''
        printf 'ID\tNAMES\tSTATUS\tPORTS\tSIZE\n'
        docker ps -a --size --format "{{printf \"%.6s\" .ID}}\t{{.Names}}\t{{index (split .Status \" \") 0}}\t{{.Ports}}\t{{.Size}}" | column -t
      '';
    };

    shellAliases = {
      mkdir = "mkdir -p";
    };
  };
  programs.fzf.enableFishIntegration = false;
  programs.direnv.enableFishIntegration = true;
  programs.direnv.config.direnv_fish_mode = "eval_on_arrow";
}
