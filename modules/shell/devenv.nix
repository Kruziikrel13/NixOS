{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.shell.devenv;
in
{
  options.modules.shell.devenv.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.devenv ];
  };
}
