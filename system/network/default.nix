{pkgs, ...}: {
  networking = {
    enable = true;
    dns = "systemd-resolved";
  };

  # TODO Verify
  resolved = {
    enable = true;
    dnsovertls = "opportunistic";
  };

  # TODO Verify
  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = ["" "${pkgs.networkmanager}/bin/nm-online -q"];
}
