{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      # doge = {
      #   hostname = "125.229.2.203";
      #   user = "liam";
      #   port = 51322;
      #   identityFile = "~/.ssh/id_ed25519";
      # };

      vivo = {
        hostname = "100.90.207.127";
        user = "liam";
        port = 55022;
        identityFile = "~/.ssh/id_ed25519";
      };

      b660m = {
        hostname = "100.88.200.118";
        user = "liam";
        port = 55022;
        identityFile = "~/.ssh/id_ed25519";
      };

      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
