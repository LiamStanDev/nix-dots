{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    # User configuration
    userName = "Liam";
    userEmail = "geffc1454@gmail.com";
    
    # Other basic settings that have direct HomeManager options
    extraConfig = {
      # Init section
      init.defaultBranch = "main";
      # Core section
      core = {
        editor = "nvim";
      };
      # Pull section
      pull.rebase = true;
      # Merge section
      merge.ff = "no";
    };
  };
}
