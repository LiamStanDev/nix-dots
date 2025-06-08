{ pkgs, ... }: {
  imports = [
    ./avahi.nix
    ./spotify.nix
  ];

  networking = {
    nameservers = [
      "9.9.9.9#dns.quad9.net" # much safer and privacy-focused DNS
      "8.8.8.8#dns.google"
    ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };

    firewall.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };

  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
}
