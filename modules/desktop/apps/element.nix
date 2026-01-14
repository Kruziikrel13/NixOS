{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.element;
in
{
  options.modules.desktop.apps.element.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.element-desktop ];
  };
}
