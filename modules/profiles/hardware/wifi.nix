{ lib, config, ... }:
with lib;
mkIf (elem "wifi" config.modules.profiles.hardware) {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
  };
}
