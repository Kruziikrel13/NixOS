{
  lib',
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.bottom;
in
{
  options.modules.shell.bottom.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.bottom ];
  };
}
