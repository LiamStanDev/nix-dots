{pkgs, ...}: {
  networking.nameservers = [
    "9.9.9.9#dns.quad9.net" # much safer and privacy-focused DNS
    "8.8.8.8#dns.google"
  ];

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
  };

  networking.firewall.enable = true;
  networking.nftables.enable = true; # defualt use iptables
  networking.firewall.allowedTCPPorts = [80 443];

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = false;
      ports = [55022];
    };

    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };

  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = ["" "${pkgs.networkmanager}/bin/nm-online -q"];

  environment.systemPackages = with pkgs; [
    iptables-nftables-compat # Compatibility with nftables
    nftables # Modern firewall system
  ];
}
