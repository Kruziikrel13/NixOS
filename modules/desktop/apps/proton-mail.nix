{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.proton-mail;
in
{
  options.modules.desktop.apps.proton-mail.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.protonmail-desktop ];
  };
}
