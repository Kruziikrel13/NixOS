{pkgs, ...}: {
  environment.systemPackages = [ pkgs.spotify ];
  services.spotifyd.enable = true;
  networking.firewall.allowedTCPPorts = [57621];
}
