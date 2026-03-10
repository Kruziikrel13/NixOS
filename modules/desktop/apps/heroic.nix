{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.heroic;
in
{
  options.modules.desktop.apps.heroic.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.heroic ];
  };
}
