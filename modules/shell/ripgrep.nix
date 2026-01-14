{
  lib',
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.ripgrep;
in
{
  options.modules.shell.ripgrep.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.ripgrep ];
  };
}
