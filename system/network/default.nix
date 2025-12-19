{ pkgs, ... }:
{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  networking.firewall.allowedTCPPorts = [
    12315 # Grayjay Desktop
  ];

  # TODO Verify
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
  };

  # TODO Verify
  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = [
    ""
    "${pkgs.networkmanager}/bin/nm-online -q"
  ];
}
