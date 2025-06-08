{ pkgs, ... }:
{
  systemd.services.iptables-rules = {
    description = "iptables firewall rules";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "iptables-setup" ''
        ${pkgs.iptables}/bin/iptables -F
        ${pkgs.iptables}/bin/iptables -P INPUT DROP
        ${pkgs.iptables}/bin/iptables -A INPUT -i lo -j ACCEPT
        ${pkgs.iptables}/bin/iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
        ${pkgs.iptables}/bin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
      '';
      RemainAfterExit = true;
    };
  };
}
