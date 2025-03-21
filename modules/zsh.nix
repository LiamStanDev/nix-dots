{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    
    # Shell options
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    
    # History settings
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 10000;
      size = 10000;
      share = true;
    };
    
    # Syntax highlighting
    syntaxHighlighting.enable = true;
    
    # Init extra script
    initExtra = ''
      # Vi mode
      bindkey -v
      export KEYTIMEOUT=1
      
      # Cursor style for different vi modes
      cursor_mode() {
        # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
        cursor_block='\e[2 q'
        cursor_beam='\e[6 q'
        
        function zle-keymap-select {
          if [[ ''${KEYMAP} == vicmd ]]; then
            echo -ne $cursor_block
          elif [[ ''${KEYMAP} == main ]] ||
               [[ ''${KEYMAP} == viins ]] ||
               [[ ''${KEYMAP} = "" ]]; then
            echo -ne $cursor_beam
          fi
        }
        
        zle -N zle-keymap-select
        
        # Ensure beam cursor when starting new terminal
        precmd_functions+=(cursor_mode)
        
        # Ensure insert mode and beam cursor when executing a command
        preexec() {
          echo -ne $cursor_beam
        }
      }
      cursor_mode
      
      # Better history search with arrow keys
      bindkey '^[[A' up-line-or-search
      bindkey '^[[B' down-line-or-search
      
      # Better delete key behavior
      bindkey '^?' backward-delete-char
      bindkey '^[[3~' delete-char
      
      # Disable bell
      unsetopt BEEP
      
      # Completions and menu
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      
      # Initialize tools
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
    '';
    
    # Aliases
    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      
      # List files
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      
      # Editors
      v = "nvim";
      n = "nvim";
      nv = "nvim";
      
      # Git
      g = "git";
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gd = "git diff";
      gl = "git log";
      
      # Tools
      lzg = "lazygit";
      lzd = "lazydocker";
      yz = "yazi";
      
      # Python
      p = "python3";
      pm = "python3 -m";
      
      # System
      cat = "bat";
      du = "dust";
      df = "duf";
      top = "btop";
      
      # Utilities
      md = "mkdir -p";
      rd = "rmdir";
      ff = "fastfetch";
    };
    
    # Plugins
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.34.0";
          sha256 = "sha256-qSobM4PRXjfsLnavmUXMvBEA1RnPDYIjYjgUQK7D06A=";
        };
      }
    ];
    
    # Oh My Zsh (alternative to plugins above)
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "history"
        "command-not-found"
        "z"
        "direnv"
      ];
    };
  };
  
  # Configure default shell
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
