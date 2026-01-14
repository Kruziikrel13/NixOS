{
  lib',
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.rust-utils;
in
{
  options.modules.shell.rust-utils.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.uutils-coreutils-noprefix ];
  };
}
