{
  programs.ssh = {
    matchBlocks = {
      doge = {
        hostname = "125.229.2.203";
        user = "liam";
        port = 51322;
        identityFile = "~/.ssh/id_ed25519";
      };
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/git_ed25519";
      };
    };
  };
}
