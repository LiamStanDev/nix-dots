{
  programs.git = {
    enable = true;

    userName = "Liam";
    userEmail = "geffc1454@gmail.com";
    delta.enable = true;
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
      };
      diff = {
        external = "difft";
        tool = "nvimdiff";
      };
      difftool = {
        prompt = false;
      };
      merge = {
        tool = "nvimdiff";
      };
      pull.rebase = true;
      merge.ff = "no";
    };

    aliases = {
      # Get the current branch name (not so useful in itself, but used in
      # other aliases)
      branch-name = "!git rev-parse --abbrev-ref HEAD";

      # Push the current branch to the remote "origin", and set it to track
      # the upstream branch
      publish = "!git push -u origin $(git branch-name)";
    };

  };
}
