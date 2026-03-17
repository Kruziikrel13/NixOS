{
  self,
  config,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (self.lib.options) mkBoolOpt mkOpt;

  cfg = config.modules.services.protonvpn;
in
{
  options.modules.services.protonvpn = with lib.types; {
    enable = mkBoolOpt false;
    autostart = mkBoolOpt true;
    conf = mkOpt str "";
  };

  config = mkIf cfg.enable {
    networking.wg-quick.interfaces."protonvpn" = {
      inherit (cfg) autostart;
      configFile = cfg.conf;
    };
  };
}
