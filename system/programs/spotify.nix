{pkgs, ...}: {
  environment.systemPackages = [ pkgs.spotify ];
  services.spotifyd.enable = true;
  firewall.allowedTCPPorts = [57621];
}
