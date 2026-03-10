{
  self,
  config,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (self.lib.options) mkBoolOpt;

  cfg = config.modules.services.protonvpn;
in
{
  options.modules.services.protonvpn = {
    enable = mkBoolOpt false;
    autostart = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    networking.wg-quick.interfaces."protonvpn" = {
      inherit (cfg) autostart;
      dns = [
        "10.2.0.1"
        "2a07:b944::2:1"
      ];
      privateKeyFile = "/root/secrets/au.prv";
      address = [
        "10.2.0.2/32"
        "2a07:b944::2:2/128"
      ];
      listenPort = 51820;

      peers = [
        {
          # AU226
          publicKey = "hPKSC01LiQsP+1pzPm98CFZXqkESBuwqdmMe+4ujeEs=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "103.216.220.98:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
