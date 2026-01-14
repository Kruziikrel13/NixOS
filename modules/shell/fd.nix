{
  lib',
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.fd;
in
{
  options.modules.shell.fd.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.fd ];
  };
}
