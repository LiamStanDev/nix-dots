{ pkgs, ... }:
{
  systemd.user.services = {

    fcitx5 = {
      Unit = {
        Description = "Fcitx Service";
      };

      Service = {
        # Why ${pkgs.fcitx5}/bin/fcitx5?
        # see: https://nixos.wiki/wiki/Fcitx5#Troubleshooting#Add-ons%20Not%20Detected
        ExecStart = "fcitx5 -d -r";
        Restart = "on-failure";
      };
    };


    udiskie = {
      Unit = {
        Description = "Udiskie Service";
      };

      Service = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie -t";
        Restart = "on-failure";
      };
    };


    waybar = {
      Unit = {
        Description = "Waybar Service";
      };

      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
      };
    };


    blueman-applet = {
      Unit = {
        Description = "Bluenman Applet Service";
      };

      Service = {
        ExecStart = "${pkgs.blueman}/bin/blueman-applet";
        Restart = "on-failure";
      };
    };


    nm-applet = {
      Unit = {
        Description = "Network Manager Applet Service";
      };

      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
    };


    mako = {
      Unit = {
        Description = "Mako Service";
      };

      Service = {
        ExecStart = "${pkgs.mako}/bin/mako";
        Restart = "on-failure";
      };
    };
  };
}
