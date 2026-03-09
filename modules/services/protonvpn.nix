{
  config,
  lib',
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;

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
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/root/secrets/au.prv";
      address = [ "10.2.0.2/32" ];
      listenPort = 51820;

      peers = [
        {
          publicKey = "2dFWLSyohbnz02CORBKdh/bPh2PUqpfJISaWIN5/fHI=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "144.48.39.226:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
