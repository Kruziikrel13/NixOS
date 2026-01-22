{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib) elem;
in
mkIf (elem "wifi" config.modules.profiles.hardware) {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };
  services.resolved = {
    enable = true;
    settings.Resolve.DNSOverTLS = "opportunistic";
  };
  user.extraGroups = [ "networkmanager" ];
  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = [
    ""
    "${pkgs.networkmanager}/bin/nm-online -q"
  ];
}
