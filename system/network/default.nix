{pkgs, ...}: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  ## For Spotify Sync
  networking.firewall.allowedTCPPorts = [57621];

  # TODO Verify
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
  };

  # TODO Verify
  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = ["" "${pkgs.networkmanager}/bin/nm-online -q"];
}
