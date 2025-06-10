{pkgs, ...}: {
  systemd.user.services = {
    udiskie = {
      Unit = {
        Description = "Udiskie Service";

        After = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie -t";
        Restart = "on-failure";
      };
    };

    waybar = {
      Unit = {
        Description = "Waybar Service";
        After = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
      };
    };

    blueman-applet = {
      Unit = {
        Description = "Bluenman Applet Service";
        After = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.blueman}/bin/blueman-applet";
        Restart = "on-failure";
      };
    };

    nm-applet = {
      Unit = {
        Description = "Network Manager Applet Service";
        After = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
    };

    mako = {
      Unit = {
        Description = "Mako Service";
        After = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.mako}/bin/mako";
        Restart = "on-failure";
      };
    };
  };
}
