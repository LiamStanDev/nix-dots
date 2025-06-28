# see: https://nixos.wiki/wiki/Flatpak
{pkgs, ...}: {
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  environment.systemPackages = with pkgs; [
    flatpak
    gnome-software
  ];
}
