{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.desktop.term.ghostty;
in
{
  options.modules.desktop.term.ghostty.enable = mkBoolOpt (
    config.modules.desktop.term.default == "ghostty"
  );
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.ghostty ];
    # TODO: Add Hjem Module
  };
}
