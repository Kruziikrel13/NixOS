{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.spotify;
in
{
  options.modules.desktop.apps.spotify.enable = mkBoolOpt false;
  config = mkIf cfg.enable {
    user.packages = [ pkgs.spotify ];
    networking.firewall.allowedTCPPorts = [ 57621 ];
    networking.firewall.allowedUDPPorts = [ 5353 ];
  };
}
