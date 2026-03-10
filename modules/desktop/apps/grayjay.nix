{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.grayjay;
in
{
  options.modules.desktop.apps.grayjay.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 12315 ];
    user.packages = [ pkgs.grayjay ];
  };
}
