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
  # networking.nftables.enable = false; # defualt use iptables
  networking.firewall.allowedTCPPorts = [80 443];

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
      ports = [55022];
    };

    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };

  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = ["" "${pkgs.networkmanager}/bin/nm-online -q"];

  # Disable ipv6 to fix libvirtd NAT inactive problem
  # boot.kernel.sysctl = {
  #   "net.ipv6.conf.all.disable_ipv6" = "1";
  #   "net.ipv6.conf.default.disable_ipv6" = "1";
  # };

  environment.systemPackages = with pkgs; [
    iptables-nftables-compat # Compatibility with nftables
    nftables # Modern firewall system
  ];
}
